#!/bin/sh
# One-shot: finish the Stow -> chezmoi migration for ~/.claude.
#
# This is separate from the rest of the migration because ~/.claude is
# currently a symlink INTO the repo, and Claude Code writes to it constantly.
# Moving it out from under a running Claude Code session risks corrupting
# in-flight session transcripts, so this must run with Claude Code quit.
#
#   1. Quit Claude Code completely.
#   2. sh ~/.dotfiles/migrate-claude-dir.sh
#   3. Delete this script (it is one-shot) and commit.

set -eu

cd "$HOME/.dotfiles"

if [ ! -L "$HOME/.claude" ]; then
  echo "~/.claude is not a symlink — migration already done. Nothing to do."
  exit 0
fi

echo "==> Moving tracked Claude config into the chezmoi source tree"
mkdir -p home/dot_claude/hooks
git mv claude/.claude/CLAUDE.md                   home/dot_claude/CLAUDE.md
git mv claude/.claude/settings.json               home/dot_claude/settings.json.tmpl
git mv claude/.claude/hooks/devbox-enforce.sh     home/dot_claude/hooks/executable_devbox-enforce.sh
git mv claude/.claude/hooks/herdr-agent-state.sh  home/dot_claude/hooks/executable_herdr-agent-state.sh

# No longer needed: runtime state stops living in the repo after this script,
# so the ignore-everything-then-allowlist workaround has nothing left to guard.
git rm -q claude/.claude/.gitignore

echo "==> Templating hardcoded home paths in settings.json"
# Covers both the Read(//Users/...) permission and the herdr hook command.
# The leading extra "/" in "Read(//Users/..." is preserved by design.
sed -i '' 's|/Users/brysonrafael|{{ .chezmoi.homeDir }}|g' home/dot_claude/settings.json.tmpl

echo "==> Replacing the ~/.claude symlink with a real directory"
rm "$HOME/.claude"
mv "$HOME/.dotfiles/claude/.claude" "$HOME/.claude"
rmdir "$HOME/.dotfiles/claude"

echo "==> Applying chezmoi (writes the 4 managed files into the real ~/.claude)"
chezmoi apply

echo
echo "==> Verifying"
printf '  ~/.claude is a real dir : '; [ -d "$HOME/.claude" ] && [ ! -L "$HOME/.claude" ] && echo yes || echo "NO - CHECK THIS"
printf '  runtime state preserved : '; du -sh "$HOME/.claude" 2>/dev/null | cut -f1
printf '  hooks executable        : '; ls -l "$HOME"/.claude/hooks/*.sh | awk '{print $1}' | tr '\n' ' '; echo
printf '  chezmoi diff is empty   : '; [ -z "$(chezmoi diff)" ] && echo yes || echo "NO - run: chezmoi diff"
printf '  no dotfiles symlinks    : '; [ -z "$(find "$HOME" -maxdepth 1 -type l -lname '*dotfiles*' 2>/dev/null)" ] && echo yes || echo "NO - stale links remain"
printf '  settings.json rendered  : '; grep -q '{{' "$HOME/.claude/settings.json" && echo "NO - template leaked" || echo yes

echo
echo "Done. Now commit:"
echo "  cd ~/.dotfiles && rm migrate-claude-dir.sh"
echo "  git add -A && git commit -m 'feat(chezmoi): Migrate ~/.claude out of the repo'"
echo "  git push"
