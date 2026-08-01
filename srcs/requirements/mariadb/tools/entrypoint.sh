#!/bin/bash
set -e

DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Initialize the MariaDB data directory only if it hasn't been done yet
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB temporarily in the background to run setup commands
    mysqld_safe --datadir=/var/lib/mysql &

    # Wait until the server is ready to accept connections
    until mysqladmin ping --silent; do
        sleep 1
    done

    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    # Stop the temporary background instance cleanly
    mysqladmin -u root -p"${DB_ROOT_PASSWORD}" shutdown
fi

# Hand off to the real foreground process (PID 1)
exec mysqld_safe --datadir=/var/lib/mysql
