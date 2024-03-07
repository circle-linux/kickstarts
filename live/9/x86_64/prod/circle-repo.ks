# These should change based on the major/minor release

# Base repos
repo --name=BaseOS --cost=200 --baseurl=http://mirror.cclinux.org/pub/circle/9/BaseOS/$basearch/os/
repo --name=AppStream --cost=200 --baseurl=http://mirror.cclinux.org/pub/circle/9/AppStream/$basearch/os/
repo --name=CRB --cost=200 --baseurl=http://mirror.cclinux.org/pub/circle/9/CRB/$basearch/os/
repo --name=extras --cost=200 --baseurl=http://mirror.cclinux.org/pub/circle/9/extras/$basearch/os

# URL to the base os repo
url --url=http://mirror.cclinux.org/pub/circle/9/BaseOS/$basearch/os/
