#!/usr/bin/env bash

##
## Setzten von Umgebungsvariablen
##

## falls nicht der Standard SSH Key verwendet wird können
## Sie hier den Pfad zu Ihrem private Key angeben
 export BORG_RSH="ssh -i /home/dojam/.ssh/id_rsa"

## Damit das Passwort vom Repository nicht eingegeben werden muss
## kann es in der Umgepungsvariable gesetzt werden
 export BORG_PASSPHRASE="HqebktiU2howNrCtGTjRoqcJ3HcN"

##
## Setzten von Variablen
##

LOG="/var/log/borg/backup.log"
BACKUP_USER="u168640"
REPOSITORY_DIR="dojam"

## Hinweis: Für die Verwendung mit einem Backup-Account muss
## 'your-storagebox.de' in 'your-backup.de' geändert werden.

REPOSITORY="ssh://${BACKUP_USER}@${BACKUP_USER}.your-storagebox.de:23/./backups/${REPOSITORY_DIR}"

##
## Ausgabe in Logdatei schreiben
##

exec > >(tee -ai ${LOG})
exec 2>&1

echo "###### Backup gestartet: $(date) ######"

##
## An dieser Stelle können verschiedene Aufgaben vor der
## Übertragung der Dateien ausgeführt werden, wie z.B.
##
## - Liste der installierten Software erstellen
## - Datenbank Dump erstellen
##
export PGUSER="dojam"

#su -c "pg_dump -Fc DOJAM_DB > /home/dojam/Documents/dojam.dump" dojam
cd /home/dojam/jamappv2
docker-compose exec -T db sh -c 'pg_dump DOJAM_DB -U dojam > /var/lib/postgresql/data/dojam.dump'

##
## Dateien ins Repository übertragen
## Gesichert werden hier beispielsweise die Ordner root, etc,
## var/www und home
## Ausserdem finden Sie hier gleich noch eine Liste Excludes,
## die in kein Backup sollten und somit per default ausgeschlossen
## werden.
##

echo "Übertrage Dateien ..."
borg create -v --stats                   \
    $REPOSITORY::'{now:%Y-%m-%d_%H:%M}'  \
    /home/dojam/jamappv2/db/dojam.dump       \
    /home/dojam/jamappv2/app/storage


echo "###### Backup beendet: $(date) ######"
