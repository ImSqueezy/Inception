#!/bin/bash

set -e

mkdir -p  /run/php

# Wait for MariaDB to be reachable before doing anything
until mariadb  -hmariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWOd}" ping  --silent -e QUIT; do
    echo "Waiting for MariaDB..."
    sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MY_PASSWORD}" \
        --dbhost="mariadb:3306" \
        --allow-root

    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root
fi

exec php-fpm7.4 -F
