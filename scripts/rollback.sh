#!/bin/bash

set -e # Abort script in case of error

echo "Executing rollback..."
scp scripts/rollback_local.sh dojam:dojam/
ssh dojam './dojam/rollback_local.sh'

echo
echo "Testing server..."
echo "Waiting 10 seconds for server to come up..."
sleep 10
response=$(curl --write-out '%{http_code}' -Iso /dev/null $(ssh -G dojam | awk '$1 == "hostname" { print $2 }'):22333)
echo "Server response code: $response"
