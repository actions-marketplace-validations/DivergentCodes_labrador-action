#!/bin/bash

image_repo="ghcr.io/divergentcodes/labrador"

# Determine Docker image tag.
if [ -z "$GHACTION_LABRADOR_DOCKER_REF" ]; then
    echo "No docker image tag defined in env var: GHACTION_LABRADOR_DOCKER_REF"
    echo "If running in Github Actions, {{ github.action_ref }} might be undefined."
    exit 1
fi

if echo "$GHACTION_LABRADOR_DOCKER_REF" | grep -qe "^v[0-9]\+"; then
    echo "Using Docker image $image_repo:$GHACTION_LABRADOR_DOCKER_REF"
else
    echo "Invalid Docker image tag: $image_repo:$GHACTION_LABRADOR_DOCKER_REF"
    exit 1
fi

# Pull and extract Labrador.
image_name="ghcr.io/divergentcodes/labrador:$GHACTION_LABRADOR_DOCKER_REF"
docker pull $image_name

container_id=$(docker create $image_name)
docker cp $container_id:/labrador ./labrador
docker rm -v $container_id

