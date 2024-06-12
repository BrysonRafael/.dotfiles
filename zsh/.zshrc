# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="intheloop"
plugins=(git rails tmux)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

# Theme
export ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# Aliases
alias clobber="bundle exec rake assets:clobber"
alias dot="cd ~/.dotfiles"
alias dot_alacritty="cd ~/.dotfiles/alacritty/.config/alacritty/"
alias dot_git="cd ~/.dotfiles/git/"
alias dot_nvim="cd ~/.dotfiles/nvim/.config/nvim/"
alias dot_starship="cd ~/.dotfiles/starship/.config/"
alias dot_tmux="cd ~/.dotfiles/tmux/"
alias dot_wez="cd ~/.dotfiles/wezterm/.config/wezterm/"
alias dot_zsh="cd ~/.dotfiles/zsh/"
alias gcm="git checkout main"
alias lg="lazygit"
alias ls="ls -a --color=auto -FC"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias precompile="bundle exec rake --trace assets:precompile"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"


# PLANNING CENTER CONFIG
eval "$($HOME/Code/pco/bin/pco init -)"
source $HOME/pco-box/env.sh

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
if [ "$(uname)" = "Darwin" ]; then
  PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
  export PATH
fi


# pyenv setup
if which pyenv &> /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  export PATH="$PYENV_ROOT/shims:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

eval "$(starship init zsh)"
