#!/bin/bash

# Install Neovim
if ! command which nvim &> /dev/null; then
  sudo snap install nvim --classic
fi

# Install GNU Stow
if ! command which stow &> /dev/null; then
  sudo apt-get update -y
  sudo apt-get install -y stow

  # Remove exising dotfiles
  rm -rf ~/.gitignore
  rm -rf ~/.zshrc
  
  # Symlink config files to home directory
  cd ~/.dotfiles
  stow git
  stow nvim
  stow zsh
fi

# If zsh is not installed
if ! command which zsh &> /dev/null; then
  # Install zsh
  sudo apt install zsh

  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Switch to zsh
  chsh -s $(which zsh) $USER
fi

