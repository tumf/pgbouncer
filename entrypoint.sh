#!/bin/sh

# Generate PgBouncer configuration file
cat <<EOF > /etc/pgbouncer/pgbouncer.ini
[databases]
${PGDATABASE:-*} = host=${PGHOST:-postgres} port=${PGPORT:-5432} user=${PGUSER:-postgres} password=${PGPASSWORD:-postgres}

[pgbouncer]
listen_addr = *
listen_port = 5432
auth_type = ${AUTH_TYPE:-md5}
auth_file = /etc/pgbouncer/userlist.txt
pool_mode = ${POOL_MODE:-session}
max_client_conn = ${MAX_CLIENT_CONN:-100}
default_pool_size = ${DEFAULT_POOL_SIZE:-20}
log_level = WARNING
EOF

# Generate userlist file
echo "\"$PGUSER\" \"md5$(echo -n "$PGPASSWORD$PGUSER" | md5sum | awk '{print $1}')\"" > /etc/pgbouncer/userlist.txt

# Start PgBouncer
exec pgbouncer /etc/pgbouncer/pgbouncer.ini
