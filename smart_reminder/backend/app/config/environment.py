import os
from enum import Enum


class Environment(str, Enum):
    development = "development"
    staging     = "staging"
    production  = "production"


def get_environment() -> Environment:
    env = os.getenv("ENVIRONMENT", "development").lower()
    try:
        return Environment(env)
    except ValueError:
        return Environment.development


def is_production() -> bool:
    return get_environment() == Environment.production


def is_development() -> bool:
    return get_environment() == Environment.development