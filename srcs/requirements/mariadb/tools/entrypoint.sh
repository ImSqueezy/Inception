#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

mysqld --user=mysql --skip-networking &
until mysqladmin ping --silent 2>/dev/null; do sleep 1; done

mysql -u root -p"${MDB_ROOT_PASS}" <<EOF
    CREATE DATABASE IF NOT EXISTS \`${MDB_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MDB_USER}'@'%' IDENTIFIED BY '${MDB_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MDB_DATABASE}\`.* TO '${MDB_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MDB_ROOT_PASS}';
    FLUSH PRIVILEGES;
EOF

mysqladmin -u root -p"${MDB_ROOT_PASS}" shutdown
exec mysqld --user=mysql
