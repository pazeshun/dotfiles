#!/bin/bash

echo -n "Do you want to install ROS newly? [Y/n] "
read ans
ans=`echo $ans | tr y Y | tr -d '[\[\]]'`  # Formatting
case $ans in
  "" | Y* )  # yes
    if [ -e /etc/apt/sources.list.d/ros-latest.list ]
    then
      echo "Confirmed the existence of ros-latest.list"
      echo -n "Which release of ROS do you want to install? : "
      read distro
      # ROS Installation
      sudo apt update
      sudo apt install ros-${distro}-desktop-full
      sudo apt install ros-${distro}-jsk-tools
      # Initialize rosdep
      sudo rosdep init
      rosdep update
      # Get rosinstall
      sudo apt install python-rosinstall
    else
      echo "Please setup sources.list and keys about ROS first"
    fi ;;
  * )  # no
    echo "ROS installation is cancelled" ;;
esac
