#!/bin/bash

# We assume set env variables BORG_REPO and BORG_PASSPHRASE
foldername="backup-check-$(date +%Y-%m-%d_%H-%M-%S)"
echo "Retrieving name of latest archive..."
latest_archive="$(borg list --short --last 1)"
echo "$latest_archive"
mkdir ./"$foldername"
cd ./"$foldername"

echo "Download latest app version to $foldername"
git clone git@bitbucket.org:BernardBeitz/jamappv2.git .

echo "Check archive history"
borg -p -v check 

echo "Extract archive $latest_archive to $foldername"
borg -p extract --strip-components 3 ::"$latest_archive"

echo "Copy secrets into backup folder"
cp ../jamappv2/config/secrets.yml config/
