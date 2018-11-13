cd ../backup-check
read -s -p "Borg passphrase: " borg_passphrase
BORG_PASSPHRASE="$borg_passphrase" borg -v -p check ssh://u168640@u168640.your-storagebox.de:23/./backups/dojam
latest_archive_name=$(BORG_PASSPHRASE="$borg_passphrase" borg list --last 1 --short ssh://u168640@u168640.your-storagebox.de:23/./backups/dojam)
BORG_PASSPHRASE="$borg_passphrase" borg list ssh://u168640@u168640.your-storagebox.de:23/./backups/dojam::2018-11-12_16:00 | wc -l
git checkout master
