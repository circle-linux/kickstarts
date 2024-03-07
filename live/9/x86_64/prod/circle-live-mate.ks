# circle-live-kde.ks
# BROKEN

%include circle-live-base-spin.ks
%include circle-live-mate-common.ks

part / --size 7168

%post
# mate configuration

sed -i 's/^livesys_session=.*/livesys_session="mate"/' /etc/sysconfig/livesys

# this doesn't come up automatically. not sure why.
systemctl enable --force lightdm.service

# CRB needs to be enabled for EPEL to function.
dnf config-manager --set-enabled crb

%end
