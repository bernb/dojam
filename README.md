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
You need the following authorizations / files:
* Full access to https://github.com/bernb/dojam
* Encrypted KeePass file `DOJAM Credentials.kdbx` containing the following secrets:
  * Database environment file `db.env`
  * Rails credential key file `master.key`

### Steps
* [Install](https://docs.docker.com/compose/install/) docker (>= 18.09.1) and docker-compose (>= 1.21.0)
* `git clone git@github.com:bernb/dojam.git` to clone the repo
* `cd dojam` to enter the project root directory
* Set `COMPOSE_FILE=docker/docker-compose-base.yml:docker/docker-compose-dev.yml` as an environmental variable for your session. Consult your operating system's documentation for more details 
* `mkdir docker/env-files` to create the local-only environment variable directory (for Windows you must use ';' as file separator)
* Copy `master.key` to `app/config/`
* Copy `db.env` to `docker/env-files/`
* Make docker accessible as a normal user: Follow the related [Post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/)
* As it takes some time to initial the database, on the first run the database will not be ready when needed by the application. So instead of just running `docker-compose up -d`, which is sufficient in principle, we split up the process:
  * `docker-compose build` to download the database image and build the application image. This will take some time
  * `docker-compose up db` to only start the database for an initial run. When postgresql signalizes it has finished its initialization kill the process (Crtl+C)
  * `docker-compose up -d` to start the containers. From now on you can use this command to start the application
* `docker-compose exec app rails db:setup` which is a simple shortcut for three commands (see [Rails guide](https://guides.rubyonrails.org/active_record_migrations.html) for more details):
  * `rails db:create` creates the databases
  * `rails db:schema:load` loads the structure (as defined in `app/db/schema.rb`)
  * `rails db:seed` applies initial data (as definied in `app/db/seeds.rb`).
  
## Restore Backup

### Requirements
You need the following authorizations / credentials:
* Access to the storage box by having your public key registered as authorized entity for the storage box
* borgbackup passphrase for the corresponding repository

## Retrieve backup
* [Install](https://borgbackup.readthedocs.io/en/stable/installation.html) borgbackup (>= 1.1.9)
* Set the following environmental variables:
  * BORG_REPO
  * BORG_PASSPHRASE 
  * See [documentation](https://borgbackup.readthedocs.io/en/stable/usage/general.html#environment-variables) for more details
* `mkdir tmp && cd tmp` to use a temporary sub folder to retrieve the backup
* `borg list --short --last 1` to get the name of the latest backup `<LATEST_BACKUP>`
* `borg extract --strip-components 2 ::<LATEST_BACKUP>` to retrieve the backup.

The structure of the backup is as following:
* `storage/` a folder containing all images and potentially other assets saved by the Rails storage provider `ActiveStorage`
* `dojam.dumb` a dumb of the postgresql database

See `scripts/get_latest_db_backup.sh` for a bash script.

## Load Backup

### Requirements
A running installation of the dojam application.

### Steps
* Replace `app/storage/` folder with the backup
* `docker-compose exec -u postgres db dropdb -U dojam DOJAM_DB` and 
* `docker-compose exec -u postgres db createdb -U dojam DOJAM_DB` to delete an recreate the database
* `docker cp dojam.dump "$(docker-compose ps -q db)":dojam.dump` to copy the database dumb into the docker container
* `docker-compose exec -T -u postgres db psql --echo-errors --quiet --dbname=DOJAM_DB --single-transaction --file=dojam.dump > /dev/null 2> db_import_errors.out` to load the dumb into the database
  * `-T` as we do not nee a TTY for this
  * `--echo-errors` as we want more verbose errors
  * `--quiet` to supress other information
  * `--single-transaction` do everything within a single transaction which means postgres will do a full rollback if any errors occur
  * `> /dev/null 2> db_import_errors.out` to redirect error messages into a file on the local machine
  * See [documentation](https://docs.docker.com/compose/reference/exec/) fore more details

See `scripts/load_latest_db_backup.sh` for a bash script. Note that this script assumes the latest within within the folder `../tmp/<LATEST_BACKUP>`.

## Release new version

### Requirements
* A working development environment of the dojam application.
* Setup an SSH alias named `dojam` in `~/.ssh/config` for the host that's running the app
  * Use public key authentication
  * Setup an SSH agent and add your key to it, so you won't be prompted to enter the password during the process. Alternatively you can use a key without a password, although that offers lower security.

### Steps
* Run `scripts/new_release.sh`
  * The previous app image is moved to `dojam_app:old_latest`
  * A backup of the database volume is created
  * The script performs a rudimentary check if the application is working. If the response code is 500, check the applications web page to see if a database migration is required. The expected response code is 302.

### Note
If the host didn't already have a working installation of the dojam app, a manual initialization of the database with `docker-compose exec app rails db:setup` on the host is necessary after installation.

## Rollback to the previous version
* Execute `scripts/rollback.sh`
 * The new version is tagged as `dojam_app:rollback_latest` and the old version from `old_latest` is restored
 * A new backup of the database is created
 * The old database backup is restored

# Allow access for new users
* Switch to the wireguard config directory
* Run `umask 077; sudo wg genkey | tee privatekey_<name> | wg pubkey > publickey_<name>` (substitute <name> with the name of the new user)
* Copy the template config `dojam_vpn_template.conf` to a new file `dojam_vpn_<name>.conf` (substitute <name> with the name of the new user)
* Copy and paste the private- and public key into the new config file `dojam_vpn_<name>.conf` after `PrivateKey = ` and `PublicKey = ` respectively
* Place `dojam_vpn_<name>.conf` into a ZIP file **protected by a password** and send it to the new user
* Send the password for the ZIP file **securely via a trusted channel** (e.g. by handing it out on paper)
