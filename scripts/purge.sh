#!/bin/bash

# Remove all docker containers with name starting with 'service-hub-'
docker rm $(docker stop $(docker ps -a --filter name="service-hub-" --format="{{.ID}}"))

# Remove unused docker images
docker image prune -a -f

# Remove unused docker volumes
docker volume prune -f
