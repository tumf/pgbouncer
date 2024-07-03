# Handy PgBouncer 

Auto generate [PgBouncer](https://www.pgbouncer.org/) (Lightweight connection pooler for PostgreSQL) configuration files `/etc/pgbouncer/pgbouncer.ini` and `/etc/pgbouncer/userlist.txt`  for single user from env vars.


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
    healthcheck:
      test: ["CMD", "/healthcheck.sh"]
      interval: 30s
      timeout: 10s
      retries: 3

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

| Environment Variable | Description                                      | Default   |
|----------------------|--------------------------------------------------|-----------|
| PGDATABASE           | The name of the PostgreSQL database to connect to| *         |
| PGHOST               | The hostname of the PostgreSQL server            | postgres  |
| PGPORT               | The port number on which the PostgreSQL server is listening | 5432      |
| PGUSER               | The username for the PostgreSQL database         | postgres  |
| PGPASSWORD           | The password for the PostgreSQL user             | postgres  |
| AUTH_TYPE            | The authentication type for PgBouncer            | md5       |
| POOL_MODE            | The pool mode for PgBouncer                      | session   |
| MAX_CLIENT_CONN      | The maximum number of client connections allowed | 100       |
| DEFAULT_POOL_SIZE    | The default pool size                            | 20        |
