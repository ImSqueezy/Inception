FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

COPY tools/index.html /var/www/html/index.html
COPY tools/styles.css /var/www/html/styles.css

CMD ["nginx", "-g", "daemon off;"]