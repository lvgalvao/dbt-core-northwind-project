FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    DBT_PROFILES_DIR=/usr/app/profiles

WORKDIR /usr/app

COPY requirements.txt .

# git: necessario para `dbt deps` resolver pacotes
# postgresql-client: traz o psql e a libpq usada em runtime pelo psycopg2
# build-essential/libpq-dev: apenas para compilar psycopg2 (dep do dbt-postgres 1.8),
#   removidos no mesmo layer para nao inflar a imagem
RUN apt-get update \
    && apt-get install -y --no-install-recommends git postgresql-client \
    && apt-get install -y --no-install-recommends build-essential libpq-dev \
    && pip install -r requirements.txt \
    && apt-get purge -y --auto-remove build-essential libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY profiles.yml /usr/app/profiles/profiles.yml
COPY northwind/ /usr/app/northwind/

WORKDIR /usr/app/northwind

# Mantem o container vivo para rodar comandos via `docker compose exec dbt ...`
CMD ["tail", "-f", "/dev/null"]
