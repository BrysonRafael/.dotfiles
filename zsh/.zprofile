os=$(uname -s)

if [ "$os" = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

