foldername="backup-check-$(date +%Y-%m-%d_%H-%M-%S)"
mkdir ../"$foldername"
cd ../"$foldername"
read -s -p "Borg passphrase: " borg_passphrase
git clone git@bitbucket.org:BernardBeitz/jamappv2.git .
BORG_PASSPHRASE=$borg_passphrase borg -p -v check ssh://u168640@u168640.your-storagebox.de:23/./backups/dojam
BORG_PASSPHRASE=$borg_passphrase borg -p extract --strip-components 3 ssh://u168640@u168640.your-storagebox.de:23/./backups/dojam::2018-11-12_16:00
cp ../jamappv2/config/secrets.yml config/
