#!/bin/sh
psql -p 5432 --host=/tmp -U pgbouncer -w pgbouncer -c "SHOW POOLS;"
