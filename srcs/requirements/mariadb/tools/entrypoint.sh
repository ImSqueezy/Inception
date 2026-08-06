#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."

    mariadb-install-db \
        --user=mysql \
        --datadir=/var/lib/mysql

    mysqld --user=mysql --bootstrap <<EOF
	USE mysql;
	CREATE DATABASE IF NOT EXISTS \`${MDB_DATABASE}\`;
	CREATE USER IF NOT EXISTS '${MDB_USER}'@'%' IDENTIFIED BY '${MDB_PASSWORD}';
	GRANT ALL PRIVILEGES ON \`${MDB_DATABASE}\`.* TO '${MDB_USER}'@'%';
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MDB_ROOT_PASS}';
	FLUSH PRIVILEGES;
EOF
fi

exec mysqld --user=mysql