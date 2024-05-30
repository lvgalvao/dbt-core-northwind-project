# syntax=docker/dockerfile:1
FROM python:3.12

# Criar e definir diretório de trabalho
RUN mkdir /northwind
WORKDIR /northwind

# Copiar o projeto
COPY dbt ./dbt

# Criar profiles.yml do dbt
RUN mkdir -p /root/.dbt
COPY profiles.yml /root/.dbt/profiles.yml

# Instalar dependências
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Comando para gerar a documentação e iniciar o container
CMD dbt docs generate --project-dir ./dbt && tail -f /dev/null
