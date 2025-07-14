# nba/wnba database
this repo contains the configs & .sql files to build my nba/wnba database

# database design
this core tables of this database (player, team, season, game) were designed with the intent normalizing the data as much as possible. the database's api (serves https://jdeko.me/bball) interacts only with "view" tables derived from the core tables

# docker
this database is fully containerized with docker. the Dockerfile and docker compose (compose.yaml) files in this repo build (and remove) the database in a single command. when `docker compose up --build` is run, the mariadb server is created in a container and the .sql files in /db are run to build the nba database.

# writes
the database is populated by a nightly python script that sources nba/wnba data, transforms it into structures compatible with the database tables, and inserts into/updates the appropriate tables

# administration
- ## procedures
    - several procedures are run daily to transform the normalized data in core tables to data that will be used by the jdeko.me/bball API
    - all procedures are called in a single script, which is run nightly via a cronjob running /scripts/run_nightly_procs.sh
- ## backups
    - backups -- via mariadb-dump -- are run daily. database `nba` is backed up to retain the data, database `mysql` is done to maintain users