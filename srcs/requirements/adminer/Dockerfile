FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y php-fpm php-mysql curl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]