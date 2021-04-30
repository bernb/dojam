# DOJAM Application

## Top Level Structure
* `/.idea` config files of rubymine IDE used by bernb
* `/app` Ruby on Rails folder, see RoR for more details on the related sub-structure
* `/docker` all files needed and related to docker(-compose)
  * `/docker/build-files` scripts consumed by docker(-compose): Entrypoints and files for initial runs
* `/infrastructure` scripts and config files that are not related to docker(-compose), for example backup related scripts
* `/scripts` development related scripts to simplify recurring tasks

## Local installation for development
This section is about how to get the app up and running for local development, DO NOT use this for production deployment.

### Requirements
You need the following authorizations / credentials:
* Full access to https://github.com/bernb/dojam
* Database environment file `db.env`
* Rails credential key file `master.key`

### Steps
* [Install](https://docs.docker.com/compose/install/) docker and docker-compose 
* `git clone git@github.com:bernb/dojam.git` to clone the repo
* `cd dojam` to enter the project root directory
* `export COMPOSE_FILE=docker/docker-compose-base.yml:docker/docker-compose-dev.yml` to set the docker-compose filepath environment variable for your session. See [documentation](https://docs.docker.com/compose/reference/envvars/) for details. Note that you might want to set this variable within `.bashrc` or some other place. Consult your operating system's documentation for more details.
* `mkdir docker/env-files` to create the local-only environment variable directory
* Copy `master.key` to `app/config/`
* Copy `db.env` to `docker/env-files/`
* `docker-compose up -d` to start the application in the background
* `docker-compose exec app rails db:setup` which is a simple shortcut for three commands (see [Rails guide](https://guides.rubyonrails.org/active_record_migrations.html) for more details):
  * `rails db:create` creates the databases
  * `rails db:schema:load` loads the structure (as defined in `app/db/schema.rb`)
  * `rails db:seed` applies initial data (as definied in `app/db/seeds.rb`).