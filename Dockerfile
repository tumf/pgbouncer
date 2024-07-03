FROM edoburu/pgbouncer
COPY ./entrypoint.sh /entrypoint.sh
COPY ./healthcheck.sh /healthcheck.sh
ENTRYPOINT ["/entrypoint.sh"]