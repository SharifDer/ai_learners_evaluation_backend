import os
import json
from pathlib import Path
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    DATABASE_URL: str = "data/assessment.db"
    LOG_LEVEL: str = "INFO"
    DEEPSEEK_API: str = ""
    USE_LLM_FEEDBACK: bool = True

    class Config:
        env_file = ".env"

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # Load API key from JSON file
        key_file = Path("keys/LLM.json")
        if key_file.exists():
            with open(key_file) as f:
                data = json.load(f)
                self.DEEPSEEK_API = data.get("DEEPSEEK_API", "")


settings = Settings()
