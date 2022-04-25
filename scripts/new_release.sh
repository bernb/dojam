#!/bin/bash

set -e # Abort script in case of error

case "$(uname -s)" in
    Linux*)     export COMPOSE_FILE="./docker/docker-compose-base.yml:./docker/docker-compose-production.yml";;
    CYGWIN*)    export COMPOSE_FILE="./docker/docker-compose-base.yml;./docker/docker-compose-production.yml";;
    MINGW*)     export COMPOSE_FILE="./docker/docker-compose-base.yml;./docker/docker-compose-production.yml";;
esac
#export COMPOSE_FILE=./docker/docker-compose-base.yml:./docker/docker-compose-production.yml
#export UID=$(id -u)
#export GID=$(id -g)

echo "Start docker-compose build..."
docker-compose build --no-cache

echo
echo "Export image as file..."
mkdir -p tmp
docker save dojam_app:latest -o tmp/dojam-app-latest.tar
rm -f tmp/dojam-app-latest.tar.bz2
bzip2 -v tmp/dojam-app-latest.tar

echo
echo "Copy image to server..."
ssh dojam 'mkdir -p dojam'
ssh dojam 'mkdir -p dojam/env-files'
ssh dojam 'mkdir -p dojam/db'
ssh dojam 'mkdir -p dojam/build-files'
scp scripts/install.sh dojam:dojam/
scp docker/docker-compose-bare.yaml dojam:dojam/
scp docker/env-files/db.env dojam:dojam/env-files/
scp docker/build-files/postgres-init.sh dojam:dojam/build-files/
rsync -v tmp/dojam-app-latest.tar.bz2 dojam:dojam/
# ssh dojam './git/dojam/scripts/install.sh'

echo
echo "Run install script..."
ssh dojam './dojam/install.sh'

echo
echo "Testing server..."
echo "Waiting 10 seconds for server to come up..."
sleep 10
response=$(curl --write-out '%{http_code}' -Iso /dev/null $(ssh -G dojam | awk '$1 == "hostname" { print $2 }'):22333)
echo "Server response code: $response"
