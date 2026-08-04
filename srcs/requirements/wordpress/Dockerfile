FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
#  -L follows direction of the new file's location on move: HTTP 301
RUN curl -fsSL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    -o /usr/local/bin/wp \
 && chmod +x /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh


ENTRYPOINT ["entrypoint.sh"]
