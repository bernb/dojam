#!/bin/bash

read -r -p "Warning: This script will DELETE the local dojam database as well as the local app storage where dojam saves it's images/files. The script will also stop all related docker containers. Continue? [y/N] " response
response=${response,,}    # tolower
if [[ ! "$response" =~ ^(yes|y)$ ]]; then
	echo "Aborted"
	exit 1;
fi

export COMPOSE_FILE="../../docker/docker-compose-base.yml:../../docker/docker-compose-dev.yml"
SCRIPT_HOME="../tmp"
cd $SCRIPT_HOME

if [ -z "$1" ]; then
	REPO=$(borg list --short --last 1)
else
	REPO=$1
fi

if [[ ! -d "$REPO" ]]; then
	echo "Directory ${SCRIPT_HOME}/${REPO} not found. Please download latest borg backup or specify which backup to use in ${SCRIPT_HOME}"
	exit 1;
fi

cd $REPO
if [[ ! -d storage ]]; then
	echo "Directory ${SCRIPT_HOME}/${REPO}/storage not found."
	exit 1;
fi

if [[ ! -f dojam.dump ]]; then
	echo "Database dump ${SCRIPT_HOME}/${REPO}/dojam.dump not found."
	exit 1;
fi


echo "Replacing app/storage/ directory"
rm -rf ../app/storage/
cp -R storage ../../app/
echo "Restarting containers"
docker-compose down
docker-compose up -d
sleep 5
echo "Dropping and recreating local DB"
docker-compose exec -u postgres db dropdb -U dojam DOJAM_DB
docker-compose exec -u postgres db createdb -U dojam DOJAM_DB
echo "Importing DB backup into local DB"
docker cp dojam.dump "$(docker-compose ps -q db)":dojam.dump
docker-compose exec -T -u postgres db psql --echo-errors --quiet --dbname=DOJAM_DB --single-transaction --file=dojam.dump > /dev/null 2> db_import_errors.out
if [[ $(wc -l < ./db_import_errors.out) -gt 0 ]]; then
	echo "Import canceled by psql. See ${SCRIPT_HOME}/db_import_errors.out for error log"
else
	echo "Completed"
fi
docker-compose down
