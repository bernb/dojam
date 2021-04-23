# DOJAM Application

## Top Level Structure
* `/.idea` config files of rubymine IDE used by bernb
* `/app` Ruby on Rails folder, see RoR for more details on the related sub-structure
* `/docker` all files needed and related to docker(-compose)
  * `/docker/build-files` scripts consumed by docker(-compose): Entrypoints and files for initial runs
* `/infrastructure` scripts and config files that are not related to docker(-compose), for example backup related scripts
* `/scripts` development related scripts to simplify recurring tasks
