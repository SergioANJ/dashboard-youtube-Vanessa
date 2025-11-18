import google_auth_oauthlib.flow
import googleapiclient.discovery
import pandas as pd

SCOPES = [
    "https://www.googleapis.com/auth/yt-analytics-monetary.readonly",
    "https://www.googleapis.com/auth/yt-analytics.readonly",
    "https://www.googleapis.com/auth/youtube.readonly"   # v3
]


def authenticate_youtube_analytics():
    flow = google_auth_oauthlib.flow.InstalledAppFlow.from_client_secrets_file(
        "client_secret.json",
        SCOPES
    )
    creds = flow.run_local_server(port=0, prompt="select_account")
    return googleapiclient.discovery.build("youtubeAnalytics", "v2", credentials=creds)

def get_channel_daily_metrics(yta, start_date, end_date):
    metrics = "views,estimatedMinutesWatched,subscribersGained,subscribersLost"
    
    request = yta.reports().query(
        ids="channel==MINE",
        startDate=start_date,
        endDate=end_date,
        metrics=metrics,
        dimensions="day",
        sort="day"
    )
    response = request.execute()

    df = pd.DataFrame(response["rows"], columns=[h["name"] for h in response["columnHeaders"]])

    #Como por ahora el canal no monetiza rellenamos de cero revenue e impressions
    # Nota: También incluimos 'subscribersLost' aquí por si la API no la devuelve.
    expected_cols = ["subscribersLost", "estimatedRevenue", "impressions"]

    # Asegurar columnas que podrían no venir
    for col in expected_cols:
        if col not in df.columns:
            df[col] = 0
            
    # Renombrar 'estimatedMinutesWatched' y 'views' para mayor claridad (opcional, pero útil)
    df.rename(columns={
    "views": "views_total",  # <--- ¡Nuevo!
    "estimatedMinutesWatched": "watch_time_minutes",
    "estimatedRevenue": "revenue" # <--- ¡Nuevo!
    }, inplace=True)


    # Convertimos minutos a horas
    df["watch_time"] = df["watch_time_minutes"] / 60
    
    df["subscribers"] = df["subscribersGained"] - df["subscribersLost"]


    return df[["day", "views_total", "watch_time", "revenue", "subscribers", "impressions"]]


def get_video_weekly_metrics(yta, start_date, end_date, youtube_data):
    metrics = "views,estimatedMinutesWatched,subscribersGained,subscribersLost"

    request = yta.reports().query(
        ids="channel==MINE",
        startDate=start_date,
        endDate=end_date,
        dimensions="video",
        metrics=metrics,
        sort="-views",
        maxResults=10
    )
    response = request.execute()

    if "rows" not in response:
        return pd.DataFrame(columns=[
            "video_id", "video_title", "week", "year", "views", "watch_time", "revenue", "subscribers", "impressions"
        ])

    df = pd.DataFrame(response["rows"], columns=[h["name"] for h in response["columnHeaders"]])
    df.rename(columns={"estimatedMinutesWatched": "watch_time_minutes"}, inplace=True)
    df["watch_time"] = df["watch_time_minutes"] / 60

    # Manejar columnas que podrían no existir
    for col in ["subscribersGained", "subscribersLost"]:
        if col not in df.columns:
            df[col] = 0

    df["subscribers"] = df["subscribersGained"] - df["subscribersLost"]
    df["revenue"] = 0
    df["impressions"] = 0

    # Traer títulos
    video_ids = df["video"].tolist()
    titles = []
    for i in range(0, len(video_ids), 50):
        batch_ids = video_ids[i:i+50]
        video_request = youtube_data.videos().list(
            part="snippet",
            id=",".join(batch_ids)
        )
        video_response = video_request.execute()
        for item in video_response.get("items", []):
            titles.append({"video": item["id"], "title": item["snippet"]["title"]})

    titles_df = pd.DataFrame(titles)
    df = df.merge(titles_df, on="video", how="left")

    # 🔹 Renombrar columnas correctas
    df.rename(columns={"video": "video_id", "title": "video_title"}, inplace=True)

    start_dt = pd.to_datetime(start_date)
    df["week"] = start_dt.isocalendar().week
    df["year"] = start_dt.isocalendar().year

    df_final = df[[ "video_id", "video_title", "week", "year", "views", "watch_time", "revenue", "subscribers", "impressions"]]

    return df_final
