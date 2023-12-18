#!/bin/bash

# install nix package manager
sh <(curl -L https://nixos.org/nix/install) --daemon

# restart current shell so we can use nix
exec bash

# install packages
nix-env -iA \
  nixpkgs.zsh \
  nixpkgs.oh-my-zsh \
  nixpkgs.neovim \
  nixpkgs.stow

# stow
stow bash
stow git
stow nvim
stow zsh

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER
