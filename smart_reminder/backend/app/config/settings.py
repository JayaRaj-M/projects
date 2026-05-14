from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    # App
    APP_NAME: str = "Smart Notes API"
    DEBUG: bool = False

    # Database
    DATABASE_URL: str = "mongodb://127.0.0.1:27017/"

    # JWT
    SECRET_KEY: str = "change-me-in-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 7  # 7 days

    # OpenAI
    OPENAI_API_KEY: str = ""

    class Config:
        env_file = ".env"


settings = Settings()