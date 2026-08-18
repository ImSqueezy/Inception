FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y php-fpm php-mysql curl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html/
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN curl -L \
    https://www.adminer.org/latest.php \
    -o /var/www/html/index.php

CMD ["php-fpm8.2", "-F"]