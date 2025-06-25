# CREATING DOCKERFILE FOR MARIADB - /06/23/2025

FROM mariadb:latest

RUN apt-get update && apt-get install -y vim && rm -rf /var/lib/apt/lists/*

WORKDIR /docker-entrypoint-initdb.d

COPY db/0-initdb.sql ./
COPY db/1-ddl.sql ./
COPY db/2-view.sql ./
COPY db/3-proc.sql ./
COPY db/4-dump.sql ./

RUN chown -R mysql:mysql /docker-entrypoint-initdb.d
