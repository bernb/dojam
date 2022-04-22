#!/bin/bash

set -e

export COMPOSE_FILE=dojam/docker-compose-bare.yaml
#export UID=$(id -u)
#export GID=$(id -g)

echo "Shutting down app..."
docker-compose down || true

echo
echo "Create DB backup..."
tar -czf dojam/db_rollback.tar.gz dojam/db

echo
echo "Restore old DB backup..."
rm  -r dojam/db
tar -xzf dojam/db_backup.tar.gz

echo
echo "Rollback app to previous version..."
docker tag dojam_app:latest dojam_app:rollback_latest
docker tag dojam_app:old_latest dojam_app:latest

echo
echo "Restarting the app..."
docker-compose up -d
