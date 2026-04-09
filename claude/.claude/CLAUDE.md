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

## Linting

When running `rubotree`, `rubocop`, or `stree`, only target files with unstaged changes — never run them against the entire project. Use `git diff --name-only` to get the file list.

## Commit Style

Use conventional commits format: `type(scope): Subject`

- **Types**: `feat`, `fix`, `chore`, `refactor`, `style`, `test`, `docs`
- **Scope**: class name, module, or area (e.g., `ConversationVertex`, `staff-tools`, `deps`, `lint`)
- **Subject line**: imperative mood, capitalize first word after colon, no trailing period
- **Body**: optional — include on non-trivial changes to explain "why" in paragraph form, wrapped at ~72 characters
- **Trivial changes**: keep terse (e.g., `chore(lint): Rubocop`)
