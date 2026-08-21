FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y wget

RUN wget -q https://github.com/google/cadvisor/releases/download/v0.47.2/cadvisor-v0.47.2-linux-amd64 -O /usr/local/bin/cadvisor && \
    chmod +x /usr/local/bin/cadvisor

ENTRYPOINT ["/usr/local/bin/cadvisor"]