#!/bin/bash

# Image is a constant.
image_repo="ghcr.io/divergentcodes/labrador"

# If ref is undefined, default to tag=latest.
if [ -z "$GHACTION_LABRADOR_DOCKER_REF" ]; then
    # If running in Github Actions, {{ github.action_ref }} might be undefined.
    echo "The Github Action version ref is empty."
    echo "Using default Docker image tag: latest"
    GHACTION_LABRADOR_DOCKER_REF="latest"

# If ref starts with v[0-9]+, use tag=version.
elif echo "$GHACTION_LABRADOR_DOCKER_REF" | grep -qe "^v[0-9]\+"; then
    echo "Using Docker image version tag: $GHACTION_LABRADOR_DOCKER_REF"

# If tag doesn't start with v[0-9], default to tag=latest.
else
    echo "The Github Action version ref is not a version tag: $GHACTION_LABRADOR_DOCKER_REF"
    echo "Using default Docker image tag: latest"
    GHACTION_LABRADOR_DOCKER_REF="latest"
fi

# Pull and extract Labrador.
image_name="$image_repo:$GHACTION_LABRADOR_DOCKER_REF"
echo "Pulling Docker image $image_name"
docker pull $image_name

container_id=$(docker create $image_name)
docker cp $container_id:/labrador ./labrador
docker rm -v $container_id

