#!/bin/bash

set -e

export COMPOSE_FILE=dojam/docker-compose-bare.yaml
#export UID=$(id -u)
#export GID=$(id -g)

echo "Info: Running as user $(whoami) ($(id -u):$(id -g))"
echo "Info: Working directory is $(pwd)"

echo
echo "Shutting down running app..."
docker-compose down || true

echo
echo "Create db and image backup..."
tar -czf dojam/db_backup.tar.gz dojam/db
(docker tag dojam_app:latest dojam_app:old_latest && docker rmi dojam_app:latest) || true

echo
echo "Load new image..."
docker load -i dojam/dojam-app-latest.tar.bz2 # && docker load -o docker/dojam-db-latest.tar

echo
echo "Restarting the app..."
docker-compose up -d
