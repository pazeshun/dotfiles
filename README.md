# dotfiles

Dotfiles in home directory.

These are dotfiles for below utils.
- bash
- git
- vim
- emacs
- clang-format
- tmux

## Installation

```sh
$ cd ~
$ git clone https://github.com/pazeshun/dotfiles.git .dotfiles
$ .dotfiles/install_scripts/install_requirements.sh  # Install requirements
$ .dotfiles/deploy.sh  # Make symbolic links in home directory
```
If you use vim first on that PC, don't forget `:PlugInstall` to install plugins.  
If you use Ubuntu 16.04, you get an error in vim-ros as it depends on python2.
To avoid this error, use `vim-nox-py2`.
```sh
$ sudo apt-get install vim-nox-py2
```
The detail is on https://github.com/taketwo/vim-ros#installation

## Where to modify

The names of source and destination of symbolic links are on `src_to_dest.sh`
