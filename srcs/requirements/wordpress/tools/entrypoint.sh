#!/bin/bash
set -e

mkdir -p /var/www/html
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

cd /var/www/html

for i in $(seq 1 30); do
    if mysqladmin ping -h mariadb -u "$MDB_USER" -p"$MDB_PASSWORD" --silent >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

if [ ! -f wp-config.php ]; then
    wp core download --allow-root --force

    wp config create --allow-root \
        --dbname="$MDB_DATABASE" \
        --dbuser="$MDB_USER" \
        --dbpass="$MDB_PASSWORD" \
        --dbhost=mariadb \
        --url="$DOMAIN_NAME"

    if ! wp core is-installed --allow-root; then
        wp core install --allow-root \
            --url="$DOMAIN_NAME" \
            --title="$WP_TITLE" \
            --admin_user="$WP_ADMIN_USER" \
            --admin_password="$WP_ADMIN_PASSWORD" \
            --admin_email="$WP_ADMIN_EMAIL"
    fi

    if ! wp user list --allow-root --field=user_login | grep -Fxq "$WP_USER"; then
        wp user create --allow-root \
            "$WP_USER" \
            "$WP_EMAIL" \
            --user_pass="$WP_PASSWORD" \
            --role=author
    fi
fi

exec php-fpm8.2 -F
