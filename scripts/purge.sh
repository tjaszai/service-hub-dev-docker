#!/bin/bash

name_prefix="service-hub-"

# Filter docker containers, volumes and images by name prefix
containers_and_images=$(docker ps -a --filter name="$name_prefix" --format="{{.ID}};{{.Image}}")
volumes=$(docker volume ls -q --filter name="$name_prefix")

for container_and_image in $(echo "$containers_and_images"); do
    elements=($(echo "$container_and_image" | tr ';' ' '))

    container="${elements[0]}"
    image="${elements[1]}"

    # Remove all docker containers with name starting with 'service-hub-'
    docker rm $(docker stop "$container") --volumes

    # If possible, remove the unused docker image ( service hub related )
    docker rmi "$image"
done

# If possible, remove the unused docker volume ( service hub related )
for volume in $(echo "$volumes"); do
    docker volume rm "$volume"
done