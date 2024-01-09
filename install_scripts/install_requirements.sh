#!/bin/bash

# Get path
INSTALL_DIRECTORY=$(cd $(dirname $0) && pwd)

# Install git submodules
. ${INSTALL_DIRECTORY}/install_submodules.sh

OS_VER=$(lsb_release -rs)

# Install clang-format
sudo apt install clang-format

# Install rlwrap
sudo apt install rlwrap

# Install python tools
if [[ ${OS_VER} < "20.04" ]]
then
  sudo apt install python-pip
  sudo pip install pip --upgrade
  sudo pip install percol
else
  sudo apt install python-is-python3
  sudo apt install python3-pip
  sudo pip3 install pip --upgrade
  sudo pip3 install percol
fi

# Install xclip for vim-fakeclip
sudo apt install xclip

# Install ROS
. ${INSTALL_DIRECTORY}/install_ros.sh
