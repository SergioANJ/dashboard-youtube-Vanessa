import streamlit as st
import pandas as pd
import psycopg2
import altair as alt
from datetime import date
import bcrypt
from db import get_monthly_progress, get_yearly_progress, get_total_year_progress

# =====================================================
# CONEXIÓN A BD
# =====================================================

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

# ---- AUTH FUNCTIONS ----
def authenticate_user(username, password):
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT u.id_usuario, u.password_hash, u.rol, s.id_subcuenta
        FROM dim_usuario u
        JOIN usuario_subcuenta us ON us.id_usuario = u.id_usuario
        JOIN dim_subcuenta s ON s.id_subcuenta = us.id_subcuenta
        WHERE u.nombre_usuario = %s AND u.activo = TRUE
    """, (username,))

    row = cur.fetchone()
    cur.close()
    conn.close()

    if row:
        user_id, stored_password, role, id_subcuenta = row
        # 🔹 Comparación simple sin bcrypt
        if password == stored_password:
            return user_id, role, id_subcuenta

    return None, None, None



# =====================================================
# CONSULTAS A BD
# =====================================================
def get_channel_metrics(start_date, end_date, id_subcuenta):
    conn = get_connection()
    query = """
        SELECT *
        FROM fact_channel_daily_metrics
        WHERE date BETWEEN %s AND %s
        AND id_subcuenta = %s
        ORDER BY date;
    """
    df = pd.read_sql(query, conn, params=(start_date, end_date, id_subcuenta))
    conn.close()
    return df


def get_top_videos(start_date, end_date, id_subcuenta):
    conn = get_connection()
    query = """
        SELECT 
            v.video_id,
            v.video_title,
            SUM(v.views) AS views,
            SUM(v.watch_time) AS watch_time,
            SUM(v.revenue) AS revenue,
            SUM(v.subscribers) AS subscribers,
            SUM(v.impressions) AS impressions
        FROM fact_video_weekly_metrics v
        WHERE 
            (
                make_date(v.year, 1, 4)
                + (v.week - 1) * 7
                - extract(isodow FROM make_date(v.year, 1, 4))::int + 1
            ) BETWEEN %s AND %s
            AND id_subcuenta = %s
        GROUP BY v.video_id, v.video_title
        ORDER BY views DESC
        LIMIT 5;
    """

    df = pd.read_sql(query, conn, params=(start_date, end_date, id_subcuenta))
    conn.close()
    return df


# =====================================================
# UI STREAMLIT
# =====================================================
st.set_page_config(page_title="Dashboard YouTube", layout="wide")

# -----------------------------------------------------
# LOGIN
# -----------------------------------------------------
if "logged_in" not in st.session_state:
    st.session_state.logged_in = False

if not st.session_state.logged_in:

    st.title("🔐 Inicio de sesión")

    username = st.text_input("Usuario")
    password = st.text_input("Contraseña", type="password")

    if st.button("Ingresar"):
        user_id, role, id_subcuenta = authenticate_user(username, password)

        if user_id:
            st.session_state.logged_in = True
            st.session_state.user_id = user_id
            st.session_state.role = role
            st.session_state.id_subcuenta = id_subcuenta
            st.rerun()
        else:
            st.error("❌ Usuario o contraseña incorrectos.")

    st.stop()


# =====================================================
# DASHBOARD
# =====================================================

st.title("📊 Dashboard de Rendimiento")
st.write(f"👋 Bienvenido **{st.session_state.role}**")

id_subcuenta = st.session_state.id_subcuenta

# ----------- Selección de fechas --------------------
st.sidebar.header("Filtros")
start_date = st.sidebar.date_input("Fecha inicial", date(2025, 1, 1))
end_date = st.sidebar.date_input("Fecha final", date(2025, 1, 31))

if start_date > end_date:
    st.sidebar.error("⚠ La fecha inicial no puede ser mayor a la final.")

# ----------- Consultar datos ------------------------
df_daily = get_channel_metrics(start_date, end_date, id_subcuenta)
df_top = get_top_videos(start_date, end_date, id_subcuenta)

if df_daily.empty:
    st.warning("No hay datos en el rango seleccionado.")
    st.stop()

# =====================================================
# KPIs
# =====================================================
st.subheader("📌 KPIs del período seleccionado")
c1, c2, c3, c4, c5 = st.columns(5)

c1.metric("👁️ Views Totales", f"{df_daily['views_total'].sum():,}")
c2.metric("⏱️ Watch Time (hrs)", f"{df_daily['watch_time'].sum():,.2f}")
c3.metric("💲 Revenue", f"${df_daily['revenue'].sum():,.2f}")
c4.metric("📈 Subscribers", f"{df_daily['subscribers'].sum():,}")
c5.metric("📢 Impressions", f"{df_daily['impressions'].sum():,}")

# =====================================================
# Gráfica Views por día
# =====================================================
st.subheader("📈 Views por día")

line_chart_views = (
    alt.Chart(df_daily)
    .mark_line(point=True)
    .encode(
        x="date:T",
        y="views_total:Q",
        tooltip=["date", "views_total"]
    )
    .interactive()
)

st.altair_chart(line_chart_views, use_container_width=True)

# =====================================================
# Gráfica Watch Time por día
# =====================================================
st.subheader("⏳ Watch Time por día")

line_chart_watch = (
    alt.Chart(df_daily)
    .mark_line(point=True)
    .encode(
        x="date:T",
        y="watch_time:Q",
        tooltip=["date", "watch_time"]
    )
    .interactive()
)

st.altair_chart(line_chart_watch, use_container_width=True)


# =====================================================
# TOP 5 VIDEOS
# =====================================================
st.subheader("🏆 Top 5 videos por semana (Lun-Dom)")

if df_top.empty:
    st.info("No hay datos de videos en el rango seleccionado.")
else:
    df_top_formatted = df_top.copy()
    df_top_formatted["views"] = df_top_formatted["views"].map(lambda x: f"{x:,}")
    df_top_formatted["watch_time"] = df_top_formatted["watch_time"].map(lambda x: f"{x:.2f}")
    df_top_formatted["revenue"] = df_top_formatted["revenue"].map(lambda x: f"${x:.2f}")
    df_top_formatted["subscribers"] = df_top_formatted["subscribers"].map(lambda x: f"{x:,}")
    df_top_formatted["impressions"] = df_top_formatted["impressions"].map(lambda x: f"{x:,}")

    st.dataframe(df_top_formatted, use_container_width=True)


# =====================================================
# SECCIÓN ESPECIAL DEL ADMIN
# =====================================================
if st.session_state.role == "admin":
    st.header("🧠 Proyección y Metas (solo Admin)")

    # ---- Selección de mes para analizar ----
    st.subheader("📌 Selecciona el mes")
    colm1, colm2 = st.columns(2)
    anio_sel = colm1.selectbox("Año", [2024, 2025, 2026], index=1)
    mes_sel = colm2.selectbox(
        "Mes",
        list(range(1, 13)),
        format_func=lambda m: ["Enero","Febrero","Marzo","Abril","Mayo","Junio",
                               "Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"][m-1]
    )

    # ---- Obtener progreso ----
    progreso_views = get_monthly_progress(id_subcuenta, "views", anio_sel, mes_sel)
    progreso_watch = get_monthly_progress(id_subcuenta, "watch_time", anio_sel, mes_sel)

    # ---- Mostrar KPIs ----
    st.subheader("📈 Progreso Views vs Meta")
    c1, c2, c3 = st.columns(3)
    c1.metric("Meta Views", f"{progreso_views['objetivo']:,}")
    c2.metric("Views Reales", f"{progreso_views['real']:,}")
    c3.metric(
        "Progreso",
        f"{progreso_views['porcentaje']:.2f}%" if progreso_views["porcentaje"] else "N/A"
    )

    st.subheader("⏱️ Progreso Watch Time vs Meta")
    d1, d2, d3 = st.columns(3)
    d1.metric("Meta Watch Time", f"{progreso_watch['objetivo']:,}")
    d2.metric("Watch Time Real", f"{progreso_watch['real']:,}")
    d3.metric(
        "Progreso",
        f"{progreso_watch['porcentaje']:.2f}%" if progreso_watch["porcentaje"] else "N/A"
    )

    # ---- Gráfica ----
    st.header("📅 Proyección Mensual vs Real (Línea de tiempo)")

    anio_proy = 2025  # puedes poner un selector luego

    df_year_views = get_yearly_progress(id_subcuenta, "views", anio_proy)

    if df_year_views.empty:
        st.warning("No hay metas cargadas para este año.")
    else:
        st.subheader("📈 Views: Meta vs Real")

        df_plot = df_year_views.melt(id_vars="mes", value_vars=["objetivo", "real"],
                                    var_name="tipo", value_name="valor")

        chart = (
            alt.Chart(df_plot)
            .mark_line(point=True)
            .encode(
                x=alt.X("mes:O", title="Mes"),
                y=alt.Y("valor:Q", title="Views"),
                color=alt.Color(
                    "tipo:N",
                    scale=alt.Scale(
                        domain=["objetivo", "real"],
                        range=["#FF5733", "#1E90FF"]
                    ),
                    title="Tipo de dato"
                ),
                tooltip=["mes", "tipo", "valor"]
            )
            .properties(height=400)
        )

        st.altair_chart(chart, use_container_width=True)

        st.header("📊 KPI Global de Progreso (Año Completo)")

        anio_global = 2025  # puedes hacer un selector luego

        # ---- Views ----
        kpi_views = get_total_year_progress(id_subcuenta, "views", anio_global)

        # ---- Watch Time ----
        kpi_watch = get_total_year_progress(id_subcuenta, "watch_time", anio_global)

        c1, c2 = st.columns(2)

        with c1:
            st.subheader("👁️ Progreso Views 2025")
            st.metric("Meta Anual", f"{kpi_views['total_meta']:,}")
            st.metric("Real Acumulado", f"{kpi_views['total_real']:,}")
            st.metric("Progreso", f"{kpi_views['porcentaje']:.2f}%")

        with c2:
            st.subheader("⏱️ Progreso Watch Time 2025")
            st.metric("Meta Anual", f"{kpi_watch['total_meta']:,}")
            st.metric("Real Acumulado", f"{kpi_watch['total_real']:,}")
            st.metric("Progreso", f"{kpi_watch['porcentaje']:.2f}%")
