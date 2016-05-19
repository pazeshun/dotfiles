#!/bin/bash

# Get path
INSTALL_DIRECTORY=$(cd $(dirname $0) && pwd)

# Install git submodules
. ${INSTALL_DIRECTORY}/install_submodules.sh

# Install clang-format
sudo apt-get install clang-format-3.6

# Install python tools
sudo apt-get install python-pip
sudo pip install percol

# Install ROS
. ${INSTALL_DIRECTORY}/install_ros.sh
