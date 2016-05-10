#!/bin/bash

# get path
DOT_DIRECTORY=$(cd $(dirname $0) && pwd)

# Include src_to_dest
. ${DOT_DIRECTORY}/src_to_dest.sh

# function to rename dotfiles for them not to be removed
rename_dotfiles () {
  if [ -e ~/${1} ]
  then
    mv -i ~/${1} ~/${1}.origin
    echo "~/${1} is found, rename it to ~/${1}.origin"
  fi
}

# Create symbolic links
for str in "${src_to_dest[@]}"
do
  ary=(`echo ${str}`)
  rename_dotfiles ${ary[1]}
  ln -snv ${DOT_DIRECTORY}/${ary[0]} ~/${ary[1]}
done
