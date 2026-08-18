# Developer Documentation

## Prerequisites

- Docker (20.10+) and Docker Compose.
- Git and a shell.

## Set up environment from scratch

1. Clone the repository.
2. Edit `srcs/.env` to set credentials and configuration (database passwords, domain name and else).
3. Ensure the bind-mount target directories exist (examples in `docker-compose.yml` point to `/home/$USER/data/...`).

## Build and launch

From the project root:

```bash
cd srcs
docker compose up --build
```

To rebuild a single service (example: nginx):

```bash
docker compose build --no-cache nginx
docker compose up -d nginx
```

## Makefile usage

If present, the Makefile may include convenience targets (clean, build, fclean). Use them as documented in the project root. Otherwise use Docker Compose directly as above.

## Manage containers and volumes

- Show running containers: `docker compose ps`
- View logs: `docker compose logs -f <service>`
- Execute a shell in a running service: `docker compose exec <service> sh`
- Stop and remove containers and volumes: `docker compose down -v`

## Where data is stored and persistence

This project uses bind mounts configured in `srcs/docker-compose.yml` to map
service data to host directories under `/home/$USER/data/` (for example:
`/home/$USER/data/mariadb` and `/home/$USER/data/wordpress`). This keeps data
persisted across container rebuilds and lets developers inspect files on the
host.
