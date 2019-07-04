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
#borg -p extract --strip-components 3 ::"$latest_archive"

# Copy secrets
cp ../app/config/secrets.yml app/config/
cp ../dojam-postgres.env .

# Check if an instance is still running and stop it
container_count=$(sudo docker-compose ps | grep jamapp | wc -l)
if [ "$container_count" -gt 0 ]; then
	sudo docker-compose down
fi

sudo docker-compose build
sudo docker-compose up --detach

sudo docker-compose exec db dropdb -U dojam DOJAM_DB
sudo docker-compose exec db createdb -U dojam DOJAM_DB
sudo docker-compose exec db pg_restore -U dojam -d DOJAM_DB /var/lib/postgresql/data/dojam.dump
sudo docker-compose exec app rails db:migrate # Call here again as we just dropped all migrations with db
sudo docker-compose exec --env RAILS_ENV=development app xvfb-run -a bundle exec rspec
sudo docker-compose down
