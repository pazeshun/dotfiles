#!/bin/bash

# get path
DOT_DIRECTORY=$(cd $(dirname $0) && pwd)

# dotfiles name
dotfiles_name=(bashrc gitconfig vim vimrc bash_aliases emacs.d)

# function to rename dotfiles for them not to be removed
rename_dotfiles () {
  if [ -e ~/${1} ]
  then
    mv -i ~/${1} ~/${1}.origin
    echo "~/${1} is found, rename it to ~/${1}.origin"
  fi
}

# dotfiles in top directory
for f in ${dotfiles_name[@]}
do
  rename_dotfiles .${f}
  ln -snv ${DOT_DIRECTORY}/${f} ~/.${f}
done

# .clang_format
rename_dotfiles .clang-format
ln -snv ${DOT_DIRECTORY}/roscpp_code_format/.clang-format ~/.clang-format
