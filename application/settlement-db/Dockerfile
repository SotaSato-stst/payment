FROM postgres:latest

ENV POSTGRES_USER=settlement_user
ENV POSTGRES_PASSWORD=default_password
ENV POSTGRES_DB=settlementdb

COPY ./data/dump.sql /docker-entrypoint-initdb.d/