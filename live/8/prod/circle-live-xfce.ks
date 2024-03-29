# circle-live-kde.ks
# BROKEN

%include circle-live-base-spin.ks
%include circle-live-xfce-common.ks

part / --size 6144

%post
# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
DISPLAYMANAGER=/usr/sbin/sddm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

mkdir -p /home/liveuser/.config/xfce4
# ugly stuff, this should give us a default background for now
mkdir -p /usr/share/backgrounds/images
ln -s ln -s /usr/share/backgrounds/f32/default/f32.png \
  /usr/share/backgrounds/images/default.png

cat > /home/liveuser/.config/xfce4/helpers.rc << FOE
MailReader=sylpheed-claws
FileManager=Thunar
WebBrowser=firefox
FOE

# disable screensaver locking (#674410)
cat >> /home/liveuser/.xscreensaver << FOE
mode:           off
lock:           False
dpmsEnabled:    False
FOE

# deactivate xfconf-migration (#683161)
rm -f /etc/xdg/autostart/xfconf-migration-4.6.desktop || :

# deactivate xfce4-panel first-run dialog (#693569)
mkdir -p /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml
cp /etc/xdg/xfce4/panel/default.xml /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# set up lightdm autologin
#sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
#sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# set Xfce as default session, otherwise login will fail
#sed -i 's/^#user-session=.*/user-session=xfce/' /etc/lightdm/lightdm.conf

# lightdm does not install on EL8 properly

# set up autologin for user liveuser
if [ -f /etc/sddm.conf ]; then
sed -i 's/^#User=.*/User=liveuser/' /etc/sddm.conf
sed -i "s/^#Session=.*/Session=xfce/" /etc/sddm.conf
else
cat > /etc/sddm.conf << SDDM_EOF
[Autologin]
User=liveuser
Session=xfce
SDDM_EOF
fi

# debrand
sed -i "s/Red Hat Enterprise/Circle/g" /usr/share/anaconda/gnome/rhel-welcome.desktop
sed -i "s/RHEL/Circle Linux/g" /usr/share/anaconda/gnome/rhel-welcome
sed -i "s/Red Hat Enterprise/Circle/g" /usr/share/anaconda/gnome/rhel-welcome
#sed -i "s/org.fedoraproject.AnacondaInstaller/fedora-logo-icon/g" /usr/share/anaconda/gnome/rhel-welcome
#sed -i "s/org.fedoraproject.AnacondaInstaller/fedora-logo-icon/g" /usr/share/applications/liveinst.desktop

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# no updater applet in live environment
rm -f /etc/xdg/autostart/org.mageia.dnfdragora-updater.desktop

# and mark it as executable (new Xfce security feature)
chmod +x /home/liveuser/Desktop/liveinst.desktop

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

# this doesn't come up automatically. not sure why.
systemctl enable sddm.service
dnf config-manager --set-enabled powertools

%end
