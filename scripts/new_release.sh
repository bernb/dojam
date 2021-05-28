#!/bin/bash

export COMPOSE_FILE=./docker/docker-compose-base.yml:./docker/docker-compose-production.yml

docker-compose build #--no-cache
docker save dojam_app:latest -o tmp/dojam-app-latest.tar
#docker save postgres -o tmp/dojam-db-latest.tar
bzip2 -v tmp/dojam-app-latest.tar
#bzip2 -v tmp/dojam-db-latest.tar
rsync -v tmp/dojam-app-latest.tar.bz2 dojam:docker/
#rsync -v tmp/dojam-db-latest.tar.bz2 dojam:docker/
ssh dojam 'docker tag dojam_app:latest dojam_app:old_latest && docker rmi dojam_app:latest'
ssh dojam 'docker load -o docker/dojam-app-latest.tar'# && docker load -o docker/dojam-db-latest.tar'
ssh dojam 'docker-compose -f /root/docker/docker-compose-base.yml -f /root/docker/docker-compose-production.yml down'
ssh dojam 'docker-compose -f /root/docker/docker-compose-base.yml -f /root/docker/docker-compose-production.yml up -d'
