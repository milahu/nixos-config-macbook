{ pkgs, ... }:

with pkgs.gnome;

[

accerciser
#adwaita-icon-theme
aisleriot
#anjuta # IDE
atomix
baobab
#callPackage
caribou
cheese # webcam screenshots
dconf-editor
#devhelp
#empathy # chat # broken
eog # eye of gnome. image viewer
#epiphany # browser
evince # document viewer
#evolution-data-server
file-roller # zip archive tool
five-or-more
four-in-a-row
#gdm # display manager
geary # email
gedit # text
ghex # hex editor
gitg
gnome-applets
gnome-autoar
gnome-backgrounds
gnome-bluetooth
#gnome-bluetooth_1_0
#gnome-books # broken
#gnome-boxes # virtual machines manager
gnome-calculator
gnome-calendar
gnome-characters
gnome-chess
gnome-clocks
gnome-color-manager
gnome-common
gnome-contacts
gnome-control-center
#gnome-desktop # removed
#gnome-devel-docs
gnome-dictionary
gnome-disk-utility
#gnome-documents # broken
gnome-flashback
gnome-font-viewer
gnome-initial-setup
gnome-keyring
gnome-klotski
gnome-logs
gnome-mahjongg
gnome-maps
gnome-mines
gnome-music
gnome-nettool
gnome-nibbles
gnome-notes
gnome-online-miners
gnome-packagekit
gnome-panel
gnome-power-manager
gnome-remote-desktop
gnome-robots
gnome-screenshot
gnome-session
gnome-session-ctl
/*
gnome-settings-daemon
gnome-settings-daemon338
gnome-settings-daemon42
gnome-settings-daemon43
*/
#gnome-shell
gnome-shell-extensions
#gnome-software # prefer nix-software-center
gnome-sound-recorder
gnome-sudoku
gnome-system-monitor
gnome-taquin
gnome-terminal
gnome-tetravex
gnome-themes-extra
gnome-todo
gnome-tweaks
gnome-user-share
gnome-weather
gpaste
#gtkhtml
gucharmap
gvfs
hitori
iagno
/*
libchamplain
libgnome-games-support
libgnome-keyring
libsoup
*/
lightsoff
metacity
mutter
/*
mutter338
mutter42
mutter43
*/
nautilus # file manager
#nautilus-python
/*
networkmanager-fortisslvpn
networkmanager-iodine
networkmanager-l2tp
networkmanager-openconnect
networkmanager-openvpn
networkmanager-vpnc
*/

# nixpkgs functions
#newScope
#nixos-gsettings-overrides
#override
#overrideDerivation
#overrideScope
#overrideScope'

#packages

polari
pomodoro
quadrapassel
#recurseForDerivations
rygel
seahorse
simple-scan
sushi
swell-foop
tali
totem
#updateScript
vinagre
yelp
#yelp-xsl
zenity

]
