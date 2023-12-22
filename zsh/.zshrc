# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"

plugins=(git rails tmux)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

# Aliases
alias dot="cd ~/.dotfiles"
alias dot_git="cd ~/.dotfiles/git/"
alias dot_nvim="cd ~/.dotfiles/nvim/.config/nvim/"
alias dot_tmux="cd ~/.dotfiles/tmux/.config/tmux/"
alias dot_wez="cd ~/.dotfiles/wezterm/.config/wezterm/"
alias dot_zsh="cd ~/.dotfiles/zsh/"
alias gcm="git checkout main"
alias ls="ls -a --color=auto -FC"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias vi="nvim"
alias vim="nvim"
alias zshconfig="nvim ~/.zshrc"


# PLANNING CENTER CONFIG
eval "$($HOME/Code/pco/bin/pco init -)"

# Cloud Box Config
if [ -f /etc/os-release ]; then
  source /etc/os-release
  if [[ $ID == "ubuntu" ]]; then
    export MYSQL_PORT_3306_TCP_ADDR=127.0.0.1
    export MYSQL_READER_PORT_3306_TCP_ADDR=127.0.0.1
    export MYSQL_READER_PORT_3306_TCP_PORT=3307
    export PATH="$HOME/pco-box/bin:/usr/local/bin:$PATH"
    source /home/ubuntu/pco-box/env.sh
  fi
fi


# WezTerm
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH


# pyenv setup
if which pyenv &> /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  export PATH="$PYENV_ROOT/shims:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


# NVM
if which nvm &> /dev/null; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # Load .nvmrc file automatically and install node version if necessary
  autoload -U add-zsh-hook

  load-nvmrc() {
    local nvmrc_path
    nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version
      nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
        nvm use
      fi
    elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }

  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

# Ruby
if which rvm &> /dev/null; then
  # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
  export PATH="$PATH:$HOME/.rvm/bin"
elif which rbenv &> /dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
