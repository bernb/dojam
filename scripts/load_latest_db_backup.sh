#!/bin/bash

read -r -p "Warning: This script will DELETE the local dojam database as well as the local app storage where dojam saves it's images/files. Continue? [y/N] " response
response=${response,,}    # tolower
if [[ ! "$response" =~ ^(yes|y)$ ]]; then
	echo "Aborted"
	exit 1;
fi

SCRIPT_HOME="../tmp"
BORG_LATEST="$(borg list --short --last 1)"

cd $SCRIPT_HOME
echo "Extracting latest DB dump: ${BORG_LATEST}..."
borg extract --progress --strip-components 4 ::$BORG_LATEST
echo "Replacing app/storage/ directory"
rm -rf ../app/storage/
mv storage/ ../app/
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
