#!/bin/bash

export COMPOSE_FILE=./docker/docker-compose-base.yml:./docker/docker-compose-production.yml
target=$1

if [ -z "$target" ]
  then
    echo "No target specified"
    exit 1
fi

echo "Testing connection to $target..."
ssh $target 'echo "Connection successful."'
if [ $? -ne 0 ]
  then
    echo "Invalid target $target."
    exit 2
fi


set -e # Abort script in case of error

echo "Start docker-compose build..."
docker-compose build --no-cache

echo
echo "Export image as file..."
mkdir -p tmp
docker save dojam_app:latest -o tmp/dojam-app-latest.tar
rm -f tmp/dojam-app-latest.tar.bz2
bzip2 -v tmp/dojam-app-latest.tar

echo
echo "Copy image to server $target..."
ssh $target 'mkdir -p dojam'
ssh $target 'mkdir -p dojam/env-files'
ssh $target 'mkdir -p dojam/db'
ssh $target 'mkdir -p dojam/build-files'
scp scripts/install.sh $target:dojam/
scp docker/docker-compose-bare.yaml $target:dojam/
scp docker/env-files/db.env $target:dojam/env-files/
scp docker/build-files/postgres-init.sh $target:dojam/build-files/
rsync -v tmp/dojam-app-latest.tar.bz2 $target:dojam/

echo
echo "Run install script..."
ssh $target './dojam/install.sh'

set +e # Do not abort script anymore
echo
echo "Testing server..."
echo "Waiting 10 seconds for server to come up..."
sleep 10
#aufteilen
hostname=$(ssh -G $target | awk '$1 == "hostname" { print $2 }')
response=$(curl --write-out '%{http_code}' -Iso /dev/null $hostname:22333)
echo "Server response code: $response"
