# Handy PgBouncer 

Auto generate configuration files `/etc/pgbouncer/pgbouncer.ini` and `/etc/pgbouncer/userlist.txt`  for single user with single database from env vars.


```yaml
services:
  pgbouncer:
    image: ghcr.io/tumf/pgbouncer:main
    environment:
      - PGHOST=${POSTGRES_HOST}
      - PGPORT=${POSTGRES_PORT}
      - PGUSER=${POSTGRES_USER}
      - PGPASSWORD=${POSTGRES_PASSWORD}
      - PGDATABASE=${POSTGRES_DB}
      - POOL_MODE=session
      - MAX_CLIENT_CONN=100
      - DEFAULT_POOL_SIZE=20
  app:
    ...
    environment:
      - DB_POSTGRESDB_HOST=pgbouncer
      - DB_POSTGRESDB_PORT=5432
      - DB_POSTGRESDB_DATABASE=${POSTGRES_DB}
      - DB_POSTGRESDB_USER=${POSTGRES_NON_ROOT_USER}
      - DB_POSTGRESDB_PASSWORD=${POSTGRES_NON_ROOT_PASSWORD}
    ...
```
