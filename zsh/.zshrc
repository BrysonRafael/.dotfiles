# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="intheloop"
plugins=(direnv git rails tmux)

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

# Env variables for neovim
export XDG_CONFIG_HOME="$HOME/.config"

# Aliases
alias be="bundle exec"
alias clobber="bundle exec rake assets:clobber"
alias claude="pco aws-login && ~/.claude/local/node_modules/.bin/claude"
alias dot="cd ~/.dotfiles"
alias dot_alacritty="cd ~/.dotfiles/alacritty/.config/alacritty/"
alias dot_ghostty="cd ~/.dotfiles/ghostty/.config/ghostty/"
alias dot_git="cd ~/.dotfiles/git/"
alias dot_guard="cd ~/.dotfiles/guard/"
alias dot_nvim="cd ~/.dotfiles/nvim/.config/nvim/"
alias dot_starship="cd ~/.dotfiles/starship/.config/"
alias dot_tmux="cd ~/.dotfiles/tmux/"
alias dot_wez="cd ~/.dotfiles/wezterm/.config/wezterm/"
alias dot_yazi="cd ~/.dotfiles/yazi/.config/yazi/"
alias dot_zsh="cd ~/.dotfiles/zsh/"
alias dr="devbox run"
alias ds="devbox shell"
alias gcm="git checkout main"
alias lg="lazygit"
alias ls="ls -a --color=auto -FC"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias precompile="bundle exec rake --trace assets:precompile"
alias rnf="bin/rspec --next-failure"
alias tail="tail -f log/development.log"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias y="yazi"

unalias gsb 2>/dev/null
gsb() {
  git checkout $(git branch --sort=-committerdate | fzf)
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# PLANNING CENTER CONFIG
if [[ -d $HOME/pco-box ]]; then
  source $HOME/pco-box/env.sh
  source ~/pco-box/bin/complete.bash
fi

if [[ -d $HOME/Code/pco ]]; then
  eval "$($HOME/Code/pco/bin/pco init -)"
fi

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi


# Church Center Android Config
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_AVD_HOME=$HOME/.android/avd
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# pyenv setup
if which pyenv &> /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  export PATH="$PYENV_ROOT/shims:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
