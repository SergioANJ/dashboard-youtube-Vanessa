import psycopg2
import pandas as pd

#Este parte de conexión de base de datos es para cuando se quieran hacer pruebas locales
"""def get_connection():
    return psycopg2.connect(
        host="localhost",
        database="proyecto_Vanessa",
        user="soporte",
        password="soporte",
        port="5433"
    )
"""
def get_connection():
    return psycopg2.connect(
        host="tramway.proxy.rlwy.net",
        port="39475",
        database="railway",
        user="postgres",
        password="NbKdnAOqBmgMXaLhwhhiDxcudsQCyLxD"
    )
# =====================================================
#  UPSERT: Métricas diarias del canal
# =====================================================
def upsert_channel_daily_metrics(conn, df):
    sql = """
    INSERT INTO fact_channel_daily_metrics
    (date, views_total, watch_time, revenue, subscribers, impressions, id_subcuenta)
    VALUES (%s, %s, %s, %s, %s, %s, %s)
    ON CONFLICT (date, id_subcuenta) DO UPDATE SET
        views_total = EXCLUDED.views_total,
        watch_time = EXCLUDED.watch_time,
        revenue = EXCLUDED.revenue,
        subscribers = EXCLUDED.subscribers,
        impressions = EXCLUDED.impressions;
    """

    cur = conn.cursor()
    for _, row in df.iterrows():
        cur.execute(sql, (
            row["day"],
            row["views_total"],
            row["watch_time"],
            row["revenue"],
            row["subscribers"],
            row["impressions"],
            row["id_subcuenta"],   # ← YA INCLUIDO
        ))
    conn.commit()
    cur.close()



# =====================================================
#  UPSERT: Métricas semanales por video
# =====================================================
def upsert_video_weekly_metrics(conn, df):
    sql = """
    INSERT INTO fact_video_weekly_metrics
    (video_id, video_title, week, year, views, watch_time, revenue, subscribers, impressions, id_subcuenta)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    ON CONFLICT (video_id, week, year, id_subcuenta) DO UPDATE SET
        video_title = EXCLUDED.video_title,
        views = EXCLUDED.views,
        watch_time = EXCLUDED.watch_time,
        revenue = EXCLUDED.revenue,
        subscribers = EXCLUDED.subscribers,
        impressions = EXCLUDED.impressions;
    """

    cur = conn.cursor()
    for _, row in df.iterrows():
        cur.execute(sql, (
            row["video_id"],
            row["video_title"],
            row["week"],
            row["year"],
            row["views"],
            row["watch_time"],
            row["revenue"],
            row["subscribers"],
            row["impressions"],
            row["id_subcuenta"],  # ← YA INCLUIDO
        ))
    conn.commit()
    cur.close()

#---------EXTRAER LA PROYECCIÓN DE LA DB------------

def get_monthly_progress(id_subcuenta, metrica, anio, mes):
    conn = get_connection()
    cur = conn.cursor()

    # 1. Obtener la meta mensual guardada
    cur.execute("""
        SELECT objetivo
        FROM dim_meta_subcuenta
        WHERE id_subcuenta = %s
        AND metrica = %s
        AND anio = %s
        AND mes = %s
    """, (id_subcuenta, metrica, anio, mes))

    row = cur.fetchone()
    objetivo = row[0] if row else 0

    # 2. Mapear la métrica a la columna correcta en la tabla real
    if metrica == "views":
        campo = "views_total"
    elif metrica == "watch_time":
        campo = "watch_time"
    else:
        raise ValueError(f"Métrica desconocida: {metrica}")

    # 3. Calcular valores reales del mes
    cur.execute(f"""
        SELECT COALESCE(SUM({campo}), 0)
        FROM fact_channel_daily_metrics
        WHERE id_subcuenta = %s
        AND EXTRACT(YEAR FROM date) = %s
        AND EXTRACT(MONTH FROM date) = %s
    """, (id_subcuenta, anio, mes))

    real = cur.fetchone()[0]

    cur.close()
    conn.close()

    porcentaje = (real / objetivo * 100) if objetivo > 0 else None

    return {
        "objetivo": objetivo,
        "real": real,
        "porcentaje": porcentaje
    }


#----------ESTA CONSULTA ES PARA EXTRAER LOS DATOS DE HACER LA LIENA DE TIEMPO DE LO HISTORICO VS REAL
def get_yearly_progress(id_subcuenta, metrica, anio):
    conn = get_connection()
    cur = conn.cursor()

    # Mapear métricas a nombres de columnas reales
    if metrica == "views":
        campo = "views_total"
    elif metrica == "watch_time":
        campo = "watch_time"
    else:
        raise ValueError("Métrica inválida")

    cur.execute(f"""
        SELECT m.mes,
               m.objetivo,
               COALESCE(SUM(f.{campo}), 0) AS real
        FROM dim_meta_subcuenta m
        LEFT JOIN fact_channel_daily_metrics f
            ON f.id_subcuenta = m.id_subcuenta
            AND EXTRACT(YEAR FROM f.date) = m.anio
            AND EXTRACT(MONTH FROM f.date) = m.mes
        WHERE m.id_subcuenta = %s
          AND m.metrica = %s
          AND m.anio = %s
        GROUP BY m.mes, m.objetivo
        ORDER BY m.mes;
    """, (id_subcuenta, metrica, anio))

    rows = cur.fetchall()
    cur.close()
    conn.close()

    df = pd.DataFrame(rows, columns=["mes", "objetivo", "real"])
    df["porcentaje"] = df.apply(
        lambda r: (r["real"] / r["objetivo"] * 100) if r["objetivo"] > 0 else None,
        axis=1
    )

    return df


#------CONSULTA PARA OBTENER PROGRESMO ANUAL TOTAL
def get_total_year_progress(id_subcuenta, metrica, anio):
    conn = get_connection()
    cur = conn.cursor()

    # Mapear métrica a columna real
    if metrica == "views":
        campo = "views_total"
    elif metrica == "watch_time":
        campo = "watch_time"
    else:
        raise ValueError("Métrica desconocida")

    # 1. Sumar todas las metas del año
    cur.execute("""
        SELECT COALESCE(SUM(objetivo), 0)
        FROM dim_meta_subcuenta
        WHERE id_subcuenta = %s
          AND metrica = %s
          AND anio = %s
    """, (id_subcuenta, metrica, anio))

    total_meta = cur.fetchone()[0]

    # 2. Sumar todo lo real del año
    cur.execute(f"""
        SELECT COALESCE(SUM({campo}), 0)
        FROM fact_channel_daily_metrics
        WHERE id_subcuenta = %s
          AND EXTRACT(YEAR FROM date) = %s
    """, (id_subcuenta, anio))

    total_real = cur.fetchone()[0]

    conn.close()

    porcentaje = (total_real / total_meta * 100) if total_meta > 0 else None

    return {
        "total_meta": total_meta,
        "total_real": total_real,
        "porcentaje": porcentaje
    }
