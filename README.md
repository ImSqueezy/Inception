*This project has been created as part of the 42 curriculum by aouaalla.*

# Inception

## Description

Inception is about having you set up a small infrastructure composed of different
services under specific rules and also providing a suitable environment for
development is Mandatory.

## Instructions

- Prerequisites: Docker and Docker Compose installed.
- From the project root run:

```bash
cd srcs
make
```

- Interact with services via a web browser:
```
    - https://aouaalla.42.fr/ or https://localhost for WordPress
    - https://adminer.localhost for adminer
    - https://portfolio.localhost for a static website
```

- Shutdown containers and volumes:

```bash
make fclean
```

## Project description (Docker usage & sources)

This project uses `docker-compose.yml` in `srcs/` to define service images and
runtime configuration. Each service has its Dockerfile under
`srcs/requirements/` (for example `srcs/requirements/mariadb/` and
`srcs/requirements/wordpress/`). Main design choices:

- Use Docker Compose (version 2.4) to orchestrate services.
- MariaDB exposes a healthcheck so WordPress waits for a healthy database.
- Nginx routes requests by hostname and proxies or passes to the appropriate
	PHP-FPM backend (WordPress or Adminer).
- Persistent data is stored via bind mounts mapped to `/home/$USER/data/…`.

## Comparaisons
This project must be done on a Virtual Machine but what's the difference between it and Docker's Containerization?

- Virtual Machines vs Containerization
	- VMs provide full OS isolation but are heavier and slower to start.
	- Docker is lightweight, faster to boot, and better for packaging single
		services.

- Secrets vs Environment Variables
	- Environment variables (or `.env`) are convenient for configuration but may
		leak in process lists or image history. Docker Secrets are safer for
		sensitive data in production. This project uses `.env` for simplicity.

- Docker Network vs Host Network
	- Bridge (Docker) networks isolate services and allow DNS-based service
		discovery (`mariadb`, `wordpress`). Host networking exposes services on the
		host interface directly and can conflict with other services. A bridge
		network is used here for isolation and portability.

- Docker Volumes vs Bind Mounts
	- Volumes are managed by Docker and are preferred for portability and
		backups. Bind mounts map to host paths which simplifies local
		development and lets the host view/edit files directly.

## Resources
- https://www.docker.com/trainings/
    - I spent some days trainings from Dockers official Docs.
- https://hpbn.co/transport-layer-security-tls/
    - A beautiful Article explaining TLS and SSL.
- [This explains the containers lifecycle](https://www.theodo.com/blog/how-better-management-of-processes-in-docker-can-greatly-improve-a-containers-lifecycle)
- [A valuable one about PHP-FPM](https://managingwp.io/2025/10/01/why-php-fpm-process-worker-limits-matter-preventing-server-outages-with-standardized-pool-configuration/)
- [Read a bit on FTP](https://cubepath.com/docs/use-cases/ftp-sftp-server-with-vsftpd)
- AI: It for learning purposes throughout this project, They were used as a reference to understand things needed to be configured a certain way, which I then implemented and tested myself.
