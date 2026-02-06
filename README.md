# WaterfoxAutoUpdater Linux x86_64
auto updater and installer to waterfox
# Dependiences:
 -Tar
 -Wget
 -Curl


 

# Installation:
Simply put the file in the user directory like /Home/User/Downloads or just /Home/user/ and make it executable using chmod +x /"updater location"/waterfoxupdater.sh and after that ./waterfoxupdater.sh It will fetch the waterfox version from a file that contains the downloaded version (waterfox-version.cwl). If the file or location /home/user/waterfox/waterfox-version.cwl doesn't exist or the (installed version) != (newest version) it will simply insttall latest stable version of waterfox and write a file with that newest version. Last step is just to add the script to autostart and it can be done for example in xfce "session and startup" by simply adding the location of the script for example /home/user/waterfoxupdater.sh  I'm sure you can do the same on KDE and Gnome or other just add the autostart of it.





# Auto Updates
If everything from the Installation was done correctly it should check if the installed waterfox version = newest waterfox version and if its not it will update it.








# Info
The script was made for the Gentoo but it will or should work on every other distro and also the updater script doesn't launch the waterfox so it's gonna be like you having everytime you boot the latest version of waterfox. It doesn't even require sudo
i just made it cuz the binary waterfox is much faster than the manually compiled firefox but remember it cant be flatpak version of it. I'm suggesting you so if you download the app that you're gonna use a lot dont install it from the flatpak



# Why to use it
Main reason that makes users use waterfox it's its clean minimalistic UI and the fact that it is lightweight and doesn't take much RAM and also boots fast .BUT if you want to have that with auto updates you cant install the waterfox from flatpak because it simply runs in flatpak runtime that slows down and increase the usage to that point that its way slower than firefox installed from package manager like APT, PACMAN, Emerge others. The script downloades the newest tarball from official waterfox resouces site the untar it and makes a symlink so you can run it via "waterfox" in terminal and it shows as the app in your desktop environment
