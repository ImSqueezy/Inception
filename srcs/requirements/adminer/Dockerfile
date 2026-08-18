FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y php-cli php-mysql curl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

RUN curl -fsSL \
    https://www.adminer.org/latest.php \
    -o /var/www/html/index.php

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]