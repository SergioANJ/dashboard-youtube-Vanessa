from youtube_api import authenticate_youtube_analytics, get_channel_daily_metrics, get_video_weekly_metrics
from db import get_connection, upsert_channel_daily_metrics, upsert_video_weekly_metrics
import googleapiclient.discovery

START_DATE = "2025-11-03"
END_DATE = "2025-11-09"

# 🔑 Muy importante:
ID_SUBCUENTA = 1   # <- ESTE VALOR DEBE VENIR DE dim_subcuenta

def main():

    print("🔐 Autenticando YouTube Analytics API...")
    yta = authenticate_youtube_analytics()
    print("✓ Autenticación completada.\n")

    print("🔗 Creando cliente YouTube Data API...")
    youtube_data = googleapiclient.discovery.build(
        "youtube", "v3", credentials=yta._http.credentials
    )
    print("✓ Cliente YouTube Data API listo.\n")

    print("🗄️ Conectando a PostgreSQL...")
    conn = get_connection()
    print("✓ Conexión establecida.\n")

    # -------------------------
    #     MÉTRICAS DIARIAS
    # -------------------------
    print("📊 Extrayendo métricas diarias del canal...")
    df_daily = get_channel_daily_metrics(yta, START_DATE, END_DATE)

    if df_daily.empty:
        print("⚠️ Advertencia: No se recibieron métricas diarias.\n")
    else:
        df_daily["id_subcuenta"] = ID_SUBCUENTA
        upsert_channel_daily_metrics(conn, df_daily)
        print(f"✓ {len(df_daily)} filas insertadas/actualizadas en channel_daily_metrics.")
        print(df_daily.head(), "\n")

    # -------------------------
    #     MÉTRICAS POR VIDEO
    # -------------------------
    print("🎬 Extrayendo métricas semanales por video...")
    df_weekly = get_video_weekly_metrics(yta, START_DATE, END_DATE, youtube_data)

    if df_weekly.empty:
        print("⚠️ Advertencia: No se recibieron métricas por video.\n")
    else:
        df_weekly["id_subcuenta"] = ID_SUBCUENTA
        upsert_video_weekly_metrics(conn, df_weekly)
        print(f"✓ {len(df_weekly)} filas insertadas/actualizadas en video_weekly_metrics.")
        print(df_weekly.head(), "\n")

    print("🧹 Cerrando conexión...")
    conn.close()
    print("✓ Conexión cerrada.\n")

    print("🚀 Todo listo, proceso completado exitosamente.")

if __name__ == "__main__":
    main()
