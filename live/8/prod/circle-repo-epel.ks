# These should change based on the major/minor release

# Deps repo, there are some anaconda packages that are *not* available by default
repo --name=BaseOS --cost=200 --baseurl=https://mirrors.xtom.de/circle/8.5/BaseOS/$basearch/os/
repo --name=AppStream --cost=200 --baseurl=https://mirrors.xtom.de/circle/8.5/AppStream/$basearch/os/
repo --name=PowerTools --cost=200 --baseurl=https://mirrors.xtom.de/circle/8.5/PowerTools/$basearch/os/
repo --name=extras --cost=200 --baseurl=https://mirrors.xtom.de/circle/8.5/extras/$basearch/os

# EPEL (required for KDE and XFCE)
repo --name=epel --cost=200 --baseurl=https://dl.fedoraproject.org/pub/epel/8/Everything/$basearch/
repo --name=epel-modular --cost=200 --baseurl=https://dl.fedoraproject.org/pub/epel/8/Modular/$basearch/

# URL to the base os repo
url --url=https://mirrors.xtom.de/circle/8.5/BaseOS/$basearch/os/
#url --url=http://10.100.0.1/pub/deps
