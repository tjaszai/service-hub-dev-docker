# Service Hub Dev Docker

Service Hub Dev Docker provides `pre-configured services` for local development of projects.
It ensures quick setup and improves development and operational efficiency.

**Pre-configured services:**

- `Reverse proxy` with Caddy
- `SMTP server` + web interface
- `PostgreSQL` ( optional )
- `Redis` ( optional )

## Requirements

- `Docker` ( v26.1.3+ ), `Docker Compose` ( v2.27.1+ )
- A shell application, for example:
    - `GNU Bash` ( Linux, macOS )
    - `Git bash` ( Windows )

## Install steps

- Clone the repository: `git clone git@github.com:tjaszai/service-hub-dev-docker.git`
- If it does not exist, create the docker network: `docker network create service-hub-ext-network`
- Open the `docker/database/.env` file and modify the values if necessary ( optional )
- Build and run the services: `docker compose up -d --build`
    - Use `--force-recreate` argument if necessary

## Scripts

- Remove all containers, unused images and volumes: `./scripts/purge.sh`
- Rebuild the `reverse-proxy` container: `./scripts/rebuild-rproxy.sh`
- Refresh the `database` container: `./scripts/refresh-db.sh`

## Services

### Reverse proxy

#### Register a new site

- Create a configuration file in the `docker/caddy/sites` directory, for example `custom-site.caddy`

  ```
  custom-site.localhost:80 {
      reverse_proxy site-container-name:80
  }
  ```

- Edit the hosts file on your machine
    - Windows: `C:\Windows\System32\drivers\etc\hosts`
    - Linux: `/etc/hosts`
    - Add the following line: `127.0.0.1 custom-site.localhost`
- Rebuild the nginx container: `./scripts/rebuild-rproxy.sh`

### Database

### Multiple databases ( optional )

- Add a new database to the `docker/database/.env` file:

  ```env
  POSTGRES_MULTIPLE_DATABASES="service-hub-default-db, service-hub-test-db, new-custom-db"
  ```

- Refresh the database container: `./scripts/refresh-db.sh`

## TODO

- [ ] SSL certificates
- [ ] Extend the bash script ( refresh-db.sh ) to remove unused databases

## License

Service Hub Dev Docker is available under the `MIT License`.
