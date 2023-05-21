# Elixir.sh
A simple bash script for refreshing your Ubuntu-based GNU-Linux operating system when it becomes slow or low on storage space.

The purpose of this script is to provide a low-effort/high-impact sweep of your system in the event that it becomes choked on resources, to quickly free up needed disc space and correct a variety of issues that can negatively affect your performance and operability.  This script is based on a MacOS-exclusive Automator script called 'Resurrection' which was created for the same purpose.

## Features in Order:
* Drops Disc Cache
* Removes cached thumbnails
* Vacuums Journal Logs older than 3 days
* Removes older versions of Snap Packages
* Removes Backup Packages
* Purges orphaned Packages
* Removes Firefox cache
* Removes VLC album thumbnails
* Empties the Trash

* Configures unconfigured Packages
* Fixes broken Packages
* Updates Repositories
* Cleans Package Manager
* Purges residual Package config files

* Lists top 8 largest files in the directory

Elixir.sh is written in bash and executed from the same directory with
```bash
bash elixir.sh

```
