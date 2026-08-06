#!/bin/bash
set -e

cd /var/www/html

if [ ! -f wp-load.php ]; then
    su -s /bin/bash www-data -c "
        wp core download --path=/var/www/html
    "
    echo "[INFO] WordPress downloaded."
else
    echo "[INFO] WordPress files already exist."
fi

if [ ! -f wp-config.php ]; then
    su -s /bin/bash www-data -c "
        wp config create \
            --path=/var/www/html \
            --dbname=\"$MDB_DATABASE\" \
            --dbuser=\"$MDB_USER\" \
            --dbpass=\"$MDB_PASSWORD\" \
            --dbhost=mariadb
    "

    echo "[INFO] wp-config.php created."
else
    echo "[INFO] wp-config.php already exists."
fi

if su -s /bin/bash www-data -c "wp core is-installed --path=/var/www/html"; then
    echo "[INFO] WordPress is already installed."
else
    su -s /bin/bash www-data -c "
        wp core install \
            --path=/var/www/html \
            --url=\"$DOMAIN_NAME\" \
            --title=\"$WP_TITLE\" \
            --admin_user=\"$WP_ADMIN_USER\" \
            --admin_password=\"$WP_ADMIN_PASSWORD\" \
            --admin_email=\"$WP_ADMIN_EMAIL\"
    "

    echo "[INFO] Creating additional user..."

    su -s /bin/bash www-data -c "
        wp user create \
            \"$WP_USER\" \
            \"$WP_EMAIL\" \
            --user_pass=\"$WP_PASSWORD\" \
            --role=author \
            --path=/var/www/html
    "

    echo "[INFO] WordPress installation complete."
fi

echo "[INFO] Fixing permissions..."
chown -R www-data:www-data /var/www/html

echo "[INFO] Starting PHP-FPM..."
exec php-fpm7.4 -F