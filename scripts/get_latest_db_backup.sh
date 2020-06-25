#!/bin/bash

SCRIPT_HOME="../tmp"
BORG_LATEST="$(borg list --short --last 1)"

cd $SCRIPT_HOME
mkdir $BORG_LATEST
cd $BORG_LATEST
echo "Extracting latest DB dump: ${BORG_LATEST}..."
borg extract --strip-components 4 ::$BORG_LATEST
