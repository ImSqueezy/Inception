FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod  +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/setup.sh"]