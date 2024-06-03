#!/bin/bash

# Rebuild the caddy reverse proxy container
docker compose stop reverse-proxy
docker compose build --no-cache reverse-proxy
docker compose up -d reverse-proxy
