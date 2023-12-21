#!/bin/bash

# Install Neovim
if ! command which nvim &> /dev/null; then
  sudo snap install nvim --classic
fi

# Install GNU Stow
if ! command which stow &> /dev/null; then
  sudo apt-get update -y
  sudo apt-get install -y stow
fi

# Install ZSH
if ! command which zsh &> /dev/null; then
  sudo apt install zsh

  # add zsh as a login shell
  command -v zsh | sudo tee -a /etc/shells

  # use zsh as default shell
  sudo chsh -s $(which zsh) $USER
fi

# Remove existing files
rm ~/.gitconfig
rm ~/.gitignore
rm ~/.zshrc

# Symlink config files to home directory
cd ~/.dotfiles
stow git
stow nvim
stow zsh
stow tmux
cd ~

# Source tmux config
tmux source-file ~/.config/tmux/tmux.conf

# install neovim plugins
nvim --headless "+Lazy! sync" +qall

# install ripgrep for telescope
sudo apt-get install ripgrep

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
exec zsh


