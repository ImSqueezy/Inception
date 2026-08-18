ADD THE REMAINING SERVICE

# User Documentation

## Services provided

- WordPress (PHP + MySQL) — main website and admin panel.
- MariaDB — database for WordPress.
- Nginx — TLS reverse proxy and PHP-FPM frontend.
- Redis — object cache for WordPress.
- Adminer — web-based DB management (adminer.${DOMAIN_NAME}).
- FTP — file transfer access to the site files.
- Website — static portfolio site proxied by Nginx.

## Start and stop

Prerequisites: Docker and Docker Compose installed.

Start the stack (from project root):

```bash
cd srcs
docker compose up -d --build
```

Stop and remove containers and volumes:

```bash
docker compose down -v
```

## Accessing the site and admin panel

- Website: https://aouaalla.42fr or https://localhost.
- WordPress admin: https://localhost/wp-admin or via the Domain.
- Adminer: https://adminer.localhost
- FTP: connect to host on port 21 (passive ports 21100–21110).

## Credentials and where to find them

Credentials are provided in `srcs/.env`. Typical variables:

- `MDB_ROOT_PASS`, `MDB_USER`, `MDB_PASSWORD`, `MDB_DATABASE` — database credentials.
- `WP_ADMIN_USER`, `WP_ADMIN_PASSWORD` — WordPress admin account.

## Check services are running

- List services: `docker compose -f srcs/docker-compose.yml ps`
- Follow logs: `docker compose -f srcs/docker-compose.yml logs -f wordpress`
- Inspect MariaDB health: `docker inspect --format='{{json .State.Health}}' mariadb`
- Check Nginx access: `docker compose -f srcs/docker-compose.yml logs -f nginx`

## Notes

See `README.md` for a short project overview and design choices.
