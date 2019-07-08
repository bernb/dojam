# Taken from 
# https://wiki.debian.org/RepackBootableISO#Remove_the_unneeded_Jigdo_production_options
orig_iso=debian-live-8.4.0-i386-standard.iso
new_files="$HOME"/iso_unpacked_and_modified
new_iso="$HOME"/debian-live-8.4.0-i386-modified.iso
mbr_template=isohdpfx.bin

# Extract MBR template file to disk
dd if="$orig_iso" bs=1 count=432 of="$mbr_template"

# Create the new ISO image
xorriso -as mkisofs \
   -r -J --joliet-long \
   -V 'Debian jessie 20160402-22:24' \
   -o "$new_iso" \
   -isohybrid-mbr "$mbr_template" \
   -partition_offset 16 \
   -c isolinux/boot.cat \
   -b isolinux/isolinux.bin \
   -no-emul-boot -boot-load-size 4 -boot-info-table \
   "$new_files"
