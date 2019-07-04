#!/bin/bash

cd ~/Projekte/jamappv2/staging-area

# check if .git dir exists aka directory already contains repo
# else clone and prepare directory
if [ -d ".git" ]; then
	git pull
else
	mkdir -p db # db is not part of repo
	git clone git@bitbucket.org:BernardBeitz/jamappv2.git
fi

# Grep latest db backup
latest_archive="$(borg list --short --last 1)"
borg -p extract --strip-components 3 ::"$latest_archive"
cp ../app/config/secrets.yml config/

docker-compose build
docker-compose up

docker-compose exec db dropdb -U dojam DOJAM_DB
docker-compose exec db createdb -U dojam DOJAM_DB
docker-compose exec db pg_restore -U dojam -d DOJAM_DB /var/lib/postgresql/data/dojam.dump
docker-compose exec app xvfb-run -a bundle exec rspec
