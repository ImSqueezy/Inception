#!/bin/bash
set -e

echo "Starting WordPress..."

chown -R www-data:www-data /var/www/html

if [ ! -f /var/www/html/wp-load.php ]; then
    echo "Downloading WordPress..."

    su -s /bin/bash www-data -c "
        wp core download \
            --path=/var/www/html
    "
fi


if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php..."

    su -s /bin/bash www-data -c "
        wp config create \
            --path=/var/www/html \
            --dbname=$MYSQL_DATABASE \
            --dbuser=$MYSQL_USER \
            --dbpass=$MYSQL_PASSWORD \
            --dbhost=mariadb
    "
fi

echo "Waiting for MariaDB..."

until wp db check
do
    sleep 2
done

if [ ! wp core is-installed ]; then
    echo "Installing WordPress..."

        wp core install \
            --path=/var/www/html \
            --url=https://$DOMAIN_NAME \
            --title='$WP_TITLE' \
            --admin_user='$WP_ADMIN_USER' \
            --admin_password='$WP_ADMIN_PASSWORD' \
            --admin_email='$WP_ADMIN_EMAIL'
fi

exec php-fpm7.4 -F
