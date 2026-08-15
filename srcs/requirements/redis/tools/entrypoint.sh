#!/bin/bash
set -e

mkdir -p /var/run/redis
chown -R redis:redis /var/run/redis

exec redis-server \
    --bind 0.0.0.0 \
    --protected-mode no