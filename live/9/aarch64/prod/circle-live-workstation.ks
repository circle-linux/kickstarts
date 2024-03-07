# Maintained by Release Engineering
# mailto:releng@circlelinux.org

%include circle-live-base.ks
%include circle-workstation-common.ks
#
# Disable this for now as packagekit is causing compose failures
# by leaving a gpg-agent around holding /dev/null open.
#
#include snippets/packagekit-cached-metadata.ks

part / --size 8192

%post

sed -i 's/^livesys_session=.*/livesys_session="gnome"/' /etc/sysconfig/livesys

%end
