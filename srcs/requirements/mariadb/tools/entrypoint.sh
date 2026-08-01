#!/bin/bash

set -e

mkdir -p /run/mysql

chown mysql:mysql /run/mysql

# Initialize the MariaDB data directory only if it hasn't been done yet
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB temporarily in the background to run setup commands
   mariadbd  --user=mysql --skip-networking --datadir=/var/lib/mysql &
    # Wait until the server is ready to accept connections
    until mariadb-admin --socket=/run/mysqld/mysqld.sock  ping --silent; do
        sleep 1
    done

    mariadbd -uroot << EOF
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
EOF

    # Stop the temporary background instance cleanly
    mariadb-admin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

# Hand off to the real foreground process (PID 1)
exec mariadbd --user=mysql --datadir=/var/lib/mysql
