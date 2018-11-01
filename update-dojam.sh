#!/bin/bash

# Attempts to forward to the latest master commit and then start
# rails specific tasks like bundle install or rails migrate

# Change into directory of script
cd "$(dirname "$0")"

(
# =================================================================
echo "10"
echo "# Checking internet connection" 
if ! ping -c1 google.com &>/dev/null ; then
	exit 11
fi

# =================================================================
echo "20"
echo "# Retrieving information about changes" 
if ! git remote update ; then
	exit 13
fi

# =================================================================
echo "30"
echo "# Synchronize with local installation" 
if ! git pull ; then
	exit 14
fi


# =================================================================
echo "40"
echo "# Post-Installation: Install new dependencies" 
if ! bundle install ; then
	exit 15
fi

# =================================================================
echo "50"
echo "# Post-Installation: Update database structure" 
if ! rails db:migrate ; then
	exit 16
fi

# =================================================================
echo "60"
echo "# Post-Installation: Update termlists. This may take a while." 
if ! rails db:seed ; then
	exit 16
fi

# =================================================================
echo "70"
echo "# Post-Installation: Restart local server" 
if ! sudo /bin/systemctl restart puma ; then
	exit 17
fi

sleep 3 # Give server time to restart

# =================================================================
echo "70"
echo "# Update complete. Starting DOJAM now" 
chromium http://localhost:22333 --password-store=basic

) |
zenity --progress \
  --title="Updating DOJAM database..." \
  --percentage=0 \
  --auto-close \
  --auto-kill \
  --no-cancel \
  --width=350

case ${PIPESTATUS[0]} in
	11)
		zenity --error --width=350 --text="Update canceled: No Internet connection."
		;;
	12)
		zenity --error --width=350 --text="Update canceled: Could not connect to remote repository."
		;;
	13)
		zenity --error --width=350 --text="Update canceled: Could not connect to remote repository."
		;;
	14)
		zenity --error --width=350 --text="Update canceled: There was a problem with merging the latest version to local."
		;;
	15)
		zenity --error --width=350 --text="Update canceled: Could not install needed dependencies"
		;;
	16)
		zenity --error --width=350 --text="Update canceled: Could not update database structure"
		;;
	17)
		zenity --error --width=350 --text="Update canceled: Could not restart local server"
		;;
esac
