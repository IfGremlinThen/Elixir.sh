#!/bin/sh
RED="\e[31m"
GREEN="32"
BOLDGREEN="\e[1;${GREEN}m"
LIGHTBLUE="\e[94m"
ENDCOLOR="\e[0m"

echo -e "${LIGHTBLUE}CLEARING DISC CACHE...${ENDCOLOR}"
  sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
echo -e "${LIGHTBLUE}CLEARING THUMBNAIL CACHE...${ENDCOLOR}"
  sudo rm -rf ~/.cache/thumbnails/*

echo -e "${LIGHTBLUE}REMOVING SYSTEMD JOURNAL LOGS OLDER THAN 3 DAYS...${ENDCOLOR}"
  sudo journalctl --vacuum-time=3d
echo -e "${LIGHTBLUE}REMOVING OLDER VERSIONS OF SNAP PACKAGES...${ENDCOLOR}"
  sudo rm -rf /var/lib/snapd/snaps/*
echo -e "${LIGHTBLUE}REMOVING BACKUP ARCHIVES FROM /VAR/...${ENDCOLOR}"
  sudo rm -rf /var/backups/*.gz
echo -e "${LIGHTBLUE}PURGING ORPHANED PACKAGES...${ENDCOLOR}"
  sudo apt autoremove -y --purge
echo -e "${LIGHTBLUE}REMOVING OBSOLETE PACKAGES & INSTALLERS...${ENDCOLOR}"
  sudo apt clean
echo -e "${LIGHTBLUE}REMOVING RESIDUAL CONFIGURATION FILES FROM REMOVED PACKAGES...${ENDCOLOR}"
  sudo dpkg -l | grep '^rc' | awk '{print $2}' | sudo xargs dpkg --purge

echo -e "${LIGHTBLUE}CLEARING FIREFOX CACHE...${ENDCOLOR}"
  cd ~/.cache/mozilla/firefox/*/cache2/entries/ && find -maxdepth 1 -name "*" -delete && cd
echo -e "${LIGHTBLUE}CLEARING VLC THUMBNAILS...${ENDCOLOR}"
  cd ~/.cache/vlc/art/arturl/ && find -maxdepth 1 -name "*" -delete && cd #CLEARS VLC ALBUM THUMBNAILS
  cd ~/.cache/vlc/art/artistalbum/ && find -maxdepth 2 -name "*" -delete && cd #CLEARS VLC ALBUM THUMBNAILS

echo -e "${LIGHTBLUE}EMPTYING THE TRASH...${ENDCOLOR}"
rm -rf ~/.local/share/Trash/files/* #EMPTIES TRASH


echo -e "${LIGHTBLUE}CONFIGURING UNCONFIGURED & UNPACKED PACKAGES...${ENDCOLOR}"
  sudo dpkg --configure -a
echo -e "${LIGHTBLUE}FIXING BROKEN PACKAGES...${ENDCOLOR}"
  sudo apt --fix-broken install
echo -e "${LIGHTBLUE}UPDATING REPOSITORIES...${ENDCOLOR}"
  sudo apt update
echo -e "${LIGHTBLUE}UPDGRADING PACKAGES...${ENDCOLOR}"
  #sudo apt upgrade -y
    #IF YOU RECEIVE "dpkg-deb: error: paste subprocess was killed by signal (Broken pipe)" THEN RUN "sudo dpkg -i --force-overwrite var/cache/apt/archives/[PACKAGE NAME]"
#echo -e "${LIGHTBLUE}PURGING NEWLY ORPHANED PACKAGES...${ENDCOLOR}"
  #sudo apt autoremove -y --purge

echo -e "${BOLDGREEN}CLEANING COMPLETE!${ENDCOLOR}"

echo "Consider addressing these files:"
cd && find -type f -exec du -Sh {} + | sort -rh | head -n 8
echo "Check /.local/share/applications for redundant files."
echo "Please restart your computer."
