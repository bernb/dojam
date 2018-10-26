#!/bin/bash


(
# =================================================================
echo "# Checking internet connection" 
if ! ping -c1 google.com &>/dev/null ; then
	exit 11
fi

# =================================================================
echo "25"
echo "# Running Second Task." ; sleep 2
# Command for second task goes on this line.

# =================================================================
echo "50"
echo "# Running Third Task." ; sleep 2
# Command for third task goes on this line.

# =================================================================
echo "75"
echo "# Running Fourth Task." ; sleep 2
# Command for fourth task goes on this line.


# =================================================================
echo "99"
echo "# Running Fifth Task." ; sleep 2
# Command for fifth task goes on this line.

# =================================================================
echo "# All finished." ; sleep 2
echo "100"


) |
zenity --progress \
  --title="Updating DOJAM database..." \
  --percentage=0 \
  --auto-close \
  --auto-kill

if [ ${PIPESTATUS[0]} -eq 11 ] ; then
	zenity --error --width=350 --text="Update canceled: No Internet connection."
fi
