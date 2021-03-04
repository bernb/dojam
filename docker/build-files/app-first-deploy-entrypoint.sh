#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /dojam/tmp/pids/server.pid

# Load the database (note that this DELETES any data that might be present) and
# seed neccessary entries
bundle exec rails db:schema:load
bundle exec rails db:seed

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
