#!/bin/bash

cd staging-area

git pull

# Grep latest db backup
latest_archive="$(borg list --short --last 1)"
borg -p extract --strip-components 3 ::"$latest_archive"
cp ../app/config/secrets.yml config/

docker-compose build
docker-compose up

cd app/
RAILS_ENV=staging rails rspec spec
# Show test-result and wait for confirmation
# Grep latest version from version file
# Increment version and write back to file
# Merge staging into master
# Move back to development branch

# Use parameters to determine if release is only to be tested or
# should be merged into master for real

#git checkout master
#git merge --no-ff development 
#git push
#git checkout development
