from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    database_username: str
    database_password: str
    database_hostname: str
    database_port: str
    database_name: str
    jwt_secret_key: str

    openai_api_key: str

    class Config:
        env_file = ".env"


settings = Settings()
