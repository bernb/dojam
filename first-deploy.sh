#!/bin/bash

set -euo pipefail

read -r -p "Warning: This script will DELETE the local database. Continue? [y/N] " response
response=${response,,}    # tolower
if [[ ! "$response" =~ ^(yes|y)$ ]]; then
	echo "Aborted"
	exit 1;
fi

docker-compose -f docker/docker-compose-base.yml -f docker/docker-compose-dev.yml run --entrypoint /usr/bin/app-first-deploy-entrypoint.sh app | tee app.log || failed=yes
docker-compose -f docker/docker-compose-base.yml -f docker/docker-compose-dev.yml logs --no-color > docker-compose.log
[[ -z "${failed:-}" ]] || exit 1
