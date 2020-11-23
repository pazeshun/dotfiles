#!/bin/bash

# For high-dpi screen with scale factor more than 1.
# Based on:
# - https://bugs.launchpad.net/ubuntu/+bug/1283424
# - https://github.com/hzbd/kazam/issues/8
# - https://mlisi.xyz/post/kazam/

# Get path
INSTALL_DIRECTORY=$(cd $(dirname $0) && pwd)

# Apply patch
cd /usr/lib/python3/dist-packages/kazam/backend
sudo cp -i gstreamer.py gstreamer.py.origin
sudo cp -i prefs.py prefs.py.origin
sudo patch -p1 < ${INSTALL_DIRECTORY}/kazam.diff
