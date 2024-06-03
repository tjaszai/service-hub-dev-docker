#!/bin/bash

# Restart the database container
docker compose stop database
docker compose up -d database --renew-anon-volumes

# Run the script to create the not existing databases
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR"/../docker/database/.env
docker compose exec database ./docker-entrypoint-initdb.d/multiple-databases.sh
