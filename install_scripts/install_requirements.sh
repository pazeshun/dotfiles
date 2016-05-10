#!/bin/bash

# Get path
INSTALL_DIRECTORY=$(cd $(dirname $0) && pwd)

# Install git submodules
. ${INSTALL_DIRECTORY}/install_submodules.sh

# Install clang-format
sudo apt-get install clang-format-3.6
