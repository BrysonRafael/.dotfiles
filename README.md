# .dotfiles

Personal macOS dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Layout

chezmoi's source root is `home/` (see `.chezmoiroot`), so everything chezmoi
manages lives there under its usual naming convention (`dot_zshrc` →
`~/.zshrc`, `dot_config/nvim` → `~/.config/nvim`, etc). Anything at the repo
root — this file, `Brewfile` — is scaffolding for the repo itself, not
something chezmoi applies to `$HOME`.

| Path | Manages |
| --- | --- |
| `home/dot_zshrc`, `dot_zprofile`, `dot_zshenv` | zsh config, aliases, shell init |
| `home/dot_gitconfig.tmpl`, `dot_gitignore` | git config, delta/lfs setup |
| `home/dot_tmux.conf` | tmux + tpm plugins |
| `home/dot_config/nvim` | [LazyVim](https://www.lazyvim.org/)-based Neovim config |
| `home/dot_config/ghostty` | Ghostty terminal config |
| `home/dot_config/yazi` | Yazi file manager (theme, keymap, plugin pins) |
| `home/dot_config/lazygit` | lazygit config |
| `home/dot_config/herdr` | [herdr](https://herdr.dev/docs/) — tmux-replacement session/pane manager |
| `home/dot_config/starship.toml` | Starship prompt |
| `home/dot_claude` | Claude Code global config, hooks, `CLAUDE.md` |

## Bootstrapping a new Mac

Starting from a bare machine (apps only, no CLI tools):

```sh
# 1. Command Line Tools — gives you git
xcode-select --install

# 2. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. chezmoi + git-lfs
brew install chezmoi git-lfs

# 4. Pull and apply the dotfiles (HTTPS avoids needing an SSH key yet)
chezmoi init --apply https://github.com/BrysonRafael/.dotfiles.git

# 5. Install everything else this machine needs
brew bundle --file=~/.dotfiles/Brewfile
```

Two things aren't brew formulae and still need their own installers:
[devbox](https://www.jetify.com/devbox) and
[oh-my-zsh](https://ohmyz.sh/). Install both, then restart your shell.

## Day-to-day

- `dot` — jump to `~/.dotfiles`
- `dot_home`, `dot_nvim`, `dot_yazi`, `dot_claude`, `dot_ghostty`, `dot_herdr`, `dot_lazygit` — jump straight into each config's directory
- `chezmoi diff` — preview what applying would change
- `chezmoi apply` — apply local edits to `$HOME`
- `chezmoi cd` — drop into the source directory in a subshell

## Keeping the Brewfile current

`Brewfile` is a snapshot, not something chezmoi keeps in sync automatically.
After installing or removing packages, refresh it and commit the diff:

```sh
brew bundle dump --file=Brewfile --force
```
