#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /dojam/tmp/pids/server.pid

# Sleep to wait for db service. See https://docs.docker.com/compose/startup-order/ for more elaborate solutions.
sleep 2
# Run migrations if neccessary
#bundle exec rails db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
