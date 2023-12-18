#!/bin/bash

# If zsh is not installed
if ! command which zsh &> /dev/null; then
  # Install zsh
  sudo apt install zsh

  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Switch to zsh
  chsh -s $(which zsh) $USER
fi

# Install Neovim
if ! command which nvim &> /dev/null; then
  sudo snap install nvim --classic
fi

# Install GNU Stow
if ! command which stow &> /dev/null; then
  sudo apt-get update -y
  sudo apt-get install -y stow
  
  # Stow configs
  cd ~/.dotfiles
  stow nvim
  stow zsh
fi
