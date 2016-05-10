#!/bin/bash

# get path
DOT_DIRECTORY=$(cd $(dirname $0) && pwd)

# Include src_to_dest
. ${DOT_DIRECTORY}/src_to_dest.sh

# function to rename dotfiles for them not to be removed
rename_dotfiles () {
  if [ -e ~/${1} ]
  then
    echo "~/${1} is found"
    # check destinations of symbolic links
    dest=`readlink ~/${1}`
    if [ "$dest" = "${DOT_DIRECTORY}/${2}" ]
    then
      rm ~/${1}
      echo "remove ~/${1} to overwrite"
    else
      mv -i ~/${1} ~/${1}.origin
      echo "rename ~/${1} to ~/${1}.origin"
    fi
  fi
}

# Create symbolic links
for str in "${src_to_dest[@]}"
do
  ary=(`echo ${str}`)
  rename_dotfiles ${ary[1]} ${ary[0]}
  ln -snv ${DOT_DIRECTORY}/${ary[0]} ~/${ary[1]}
done
