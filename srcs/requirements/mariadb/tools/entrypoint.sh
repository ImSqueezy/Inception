#!/bin/bash
set -e

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."

    mariadb-install-db \
        --user=mysql \
        --datadir=/var/lib/mysql

    mysqld --user=mysql --bootstrap <<EOF
	CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

	ALTER USER 'root'@'localhost'
	IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

	FLUSH PRIVILEGES;
EOF
fi

exec mysqld --user=mysql
