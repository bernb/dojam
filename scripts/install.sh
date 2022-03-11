#!/bin/bash

set -e

#export COMPOSE_FILE=git/dojam/docker/docker-compose-base.yml:git/dojam/docker/docker-compose-production.yml
export COMPOSE_FILE=dojam/docker-compose-bare.yaml

echo "$PWD"

(docker tag dojam_app:latest dojam_app:old_latest && docker rmi dojam_app:latest) || true
docker load -i dojam/dojam-app-latest.tar.bz2 # && docker load -o docker/dojam-db-latest.tar
docker-compose down || true
docker-compose up -d
