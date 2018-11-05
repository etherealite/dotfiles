# start vmware open tools vmblock
sudo modprobe vmblock

# enable vmware clipboard sharing
vmware-user-suid-wrapper

# turn of the bell
xset b off

# merge personal x11 prefs
xrdb -merge ~/.Xresources

#start the window manager
#exec awesome
