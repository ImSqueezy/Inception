#!/bin/bash
set -e

mkdir -p /var/www/adminer

if [ ! -f /var/www/adminer/index.php ]; then
    curl -fsSL https://www.adminer.org/latest.php \
        -o /var/www/adminer/index.php
fi

exec php-fpm8.2 -F