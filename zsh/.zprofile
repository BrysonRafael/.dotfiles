os=$(uname -s)

if [ "$os" = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Added by `rbenv init` on Sun Apr 20 06:22:19 CDT 2025
eval "$(rbenv init - --no-rehash zsh)"
