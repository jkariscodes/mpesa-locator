from .base import *

# Take environment variables from .env file
environ.Env.read_env(os.path.join(BASE_DIR, ".env"))

ENVIRONMENT = "development"

SECRET_KEY = env("SECRET_KEY")

DEBUG = True

ALLOWED_HOSTS = env("ALLOWED_HOSTS").split(" ")

# Database configuration
DATABASES = {
    "default": {
        "ENGINE": env("ENGINE"),
        "NAME": env("GIS_DB_NAME"),
        "USER": env("GIS_DB_USER"),
        "PASSWORD": env("GIS_DB_PASSWORD"),
        "HOST": env("POSTGRES_HOST"),
        "PORT": env("POSTGRES_PORT"),
    }
}
