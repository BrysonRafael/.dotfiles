# Global Claude Code Instructions

## Devbox + direnv

Projects under `~/Code` that use devbox (i.e. have a `devbox.json`) also use direnv via an `.envrc` file. When running shell commands in these projects, always prefix with `direnv exec .` instead of `devbox run` to get the correct environment. `devbox run` resolves to the global devbox config and uses the wrong tool versions (e.g., system Ruby 2.6 instead of the project's Ruby 3.3).

Example:
- Instead of: `devbox run bundle exec rubocop ...`
- Use: `direnv exec . bundle exec rubocop ...`
