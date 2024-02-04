FROM postgres:latest

ENV POSTGRES_USER=payment_user
ENV POSTGRES_PASSWORD=default_password
ENV POSTGRES_DB=paymentdb

COPY ./data/dump.sql /docker-entrypoint-initdb.d/