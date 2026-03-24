# Global Claude Code Instructions

## Devbox + direnv

Projects under `~/Code` that use devbox (i.e. have a `devbox.json`) also use direnv via an `.envrc` file. When running shell commands in these projects, prefix with `direnv exec .` to get the correct environment.

Example:
- Instead of: `bundle exec rubocop ...`
- Use: `direnv exec . bundle exec rubocop ...`

## Git Worktrees

When creating git worktrees in projects that use devbox, always use the `new_worktree` shell function instead of `git worktree add`. `new_worktree` runs `bundle install` via `direnv exec` immediately after creating the worktree, ensuring gems are compiled against the correct Ruby version.

- Instead of: `git worktree add <path> <branch>`
- Use: `new_worktree <path> <branch>`
