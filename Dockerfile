# syntax=docker/dockerfile:1
FROM python:3.12

WORKDIR /usr/app/northwind

# Instalar dependências
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Comando para manter o container rodando
CMD tail -f /dev/null
