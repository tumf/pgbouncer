#!/bin/sh

# Generate PgBouncer configuration file
cat <<EOF > /etc/pgbouncer/pgbouncer.ini
[databases]
* = host=${PGHOST} port=${PGPORT} user=${PGUSER} password=${PGPASSWORD}

[pgbouncer]
listen_addr = *
listen_port = 5432
auth_type = ${AUTH_TYPE:-md5}
auth_file = /etc/pgbouncer/userlist.txt
pool_mode = ${POOL_MODE:-session}
max_client_conn = ${MAX_CLIENT_CONN:-100}
default_pool_size = ${DEFAULT_POOL_SIZE:-20}
EOF

# Generate userlist file
echo "\"$PGUSER\" \"md5$(echo -n "$PGPASSWORD$PGUSER" | md5sum | awk '{print $1}')\"" > /etc/pgbouncer/userlist.txt

# Start PgBouncer
exec pgbouncer /etc/pgbouncer/pgbouncer.ini
