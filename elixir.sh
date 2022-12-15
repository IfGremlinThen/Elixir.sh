#!/bin/sh
echo "UPDATING PACKAGE CATALOG..."
  sudo dpkg --configure -a #CONFIGURES ANY UNCONFIGURED & UNPACKED PACKAGES
  sudo apt --fix-broken install #-y #SEARCHES FOR BROKEN PACKAGES
  sudo apt update #UPDATES EXISTING REPOSITORIES
  sudo apt upgrade -y #UPDATES PACKAGES FROM REPOSITORIES
    #IF YOU RECEIVE "dpkg-deb: error: paste subprocess was killed by signal (Broken pipe)" THEN RUN "sudo dpkg -i --force-overwrite var/cache/apt/archives/[PACKAGE NAME]"
  sudo apt autoremove -y #REMOVES OBSOLETE PACKAGES PREVIOUSLY INSTALLED AS DEPENDENCIES
echo "CLEARING SYSTEM CACHE..."
  sudo apt autoclean #REMOVES OBSOLETE PACKAGE CACHES
  sync && echo 3 | sudo tee /proc/sys/vm/drop_caches #CLEAR DISC CACHE
  journalctl --disk-usage #CHECKS DISC USAGE OF SYSTEMD JOURNAL LOGS, LOCATED IN /VAR/LOG/JOURNAL
  sudo journalctl --vacuum-time=3d #REMOVES SYSTEMD JOURNAL LOGS OLDER THAN 3 DAYS
  sudo rm -rf /var/lib/snapd/snaps/* #REMOVES OLDER VERSIONS OF SNAP PACKAGES
  sudo rm -rf ~/.cache/thumbnails/* #REMOVES ENTIRE THUMBNAIL CACHE

echo "Consider addressing these files:"
cd && find -type f -exec du -Sh {} + | sort -rh | head -n 8
echo "Check /.local/share/applications for redundant files."
echo "Please restart your computer."

#REMOVE RESIDUAL CONFIGURATION FILES FROM REMOVED PACKAGES
#sudo dpkg -l | grep '^rc' | awk '{print $2}' | sudo xargs dpkg --purge
