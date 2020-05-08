#!/bin/bash

#ssh-add

SCRIPT_HOME="/home/$USER/Projekte/dojam/"
BORG_LATEST="$(borg list --short --last 1)"

cd $SCRIPT_HOME
borg extract --strip-components 4 ::$BORG_LATEST home/dojam/jamappv2/db/dojam.dump
docker-compose exec -u postgres db dropdb -U dojam DOJAM_DB
docker-compose exec -u postgres db createdb -U dojam DOJAM_DB
docker-compose exec -u postgres db psql -a -c -U dojam -d DOJAM_DB dojam.dump

