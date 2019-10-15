#!/bin/bash

# Get path
INSTALL_DIRECTORY=$(cd $(dirname $0) && pwd)

# Install git submodules
. ${INSTALL_DIRECTORY}/install_submodules.sh

# Install clang-format
sudo apt install clang-format-3.6

# Install rlwrap
sudo apt install rlwrap

# Install python tools
sudo apt install python-pip
sudo pip install pip --upgrade
sudo pip install percol

# Install ROS
. ${INSTALL_DIRECTORY}/install_ros.sh
