#!/bin/bash

case "$(uname -s)" in
    Linux*)     export COMPOSE_FILE="./docker/docker-compose-base.yml:./docker/docker-compose-production.yml";;
    CYGWIN*)    export COMPOSE_FILE="./docker/docker-compose-base.yml;./docker/docker-compose-production.yml";;
    MINGW*)     export COMPOSE_FILE="./docker/docker-compose-base.yml;./docker/docker-compose-production.yml";;
esac
#export COMPOSE_FILE=./docker/docker-compose-base.yml:./docker/docker-compose-production.yml
#export UID=$(id -u)
#export GID=$(id -g)

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

set +e # Do not abort script anymore
echo
echo "Testing server..."
#echo "Waiting 10 seconds for server to come up..."
#sleep 10

hostname=$(ssh -G $target | awk '$1 == "hostname" { print $2 }')
echo "$hostname"
response=$(curl --write-out '%{http_code}' -Iso /dev/null $hostname:22333)
echo "Server response code: $response"
