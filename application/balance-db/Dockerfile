FROM postgres:latest

ENV POSTGRES_USER=balance_user
ENV POSTGRES_PASSWORD=default_password
ENV POSTGRES_DB=balancedb

COPY ./data/dump.sql /docker-entrypoint-initdb.d/