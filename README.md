# WaterfoxAutoUpdater
auto updater and installer to waterfox
# Dependiences:
 -Tar
 -Wget
 -Curl

# Installation:
Simply put the file in the user directory like /Home/User/Downloads or just /Home/user/ and make it executable using chmod +x /"updater location"/waterfoxupdater.sh and after that ./waterfoxupdater.sh It will fetch the waterfox version from a file that it contains the downloaded version (waterfox-version.cwl). If the file or location /home/user/waterfox/waterfox-version.cwl doesn't exist or the (installed version) != (newest version) it will simply insttall latest stable version of waterfox and write a file with that newest version. Last step is just to add the script to autostart and it can be done for example in xfce "session and startup" by simply adding the location of the script for example /home/user/waterfoxupdater.sh  I'm sure you can do the same on KDE and Gnome or other just add the autostart of it.

# Auto Updates
If everything from the Installation was done correctly it should check if the installed waterfox version = newest waterfox version and if its not it will update it.
