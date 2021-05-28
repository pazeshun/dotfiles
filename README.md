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

## Where to modify

The names of source and destination of symbolic links are on `src_to_dest.sh`
