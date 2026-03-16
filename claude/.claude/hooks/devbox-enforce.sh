#!/usr/bin/env bash

set -euo pipefail

INPUT=$(cat)

CWD=$(echo "$INPUT" | jq -r '.cwd')
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command')

# Only enforce in projects with devbox.json
[[ -f "$CWD/devbox.json" ]] || exit 0

# Already using devbox
[[ "$COMMAND" != devbox* ]] || exit 0

# Strip leading env var assignments, get first command basename
first_cmd=$(echo "$COMMAND" | sed -E 's/^([A-Za-z_][A-Za-z_0-9]*=[^ ]* )*//;s/ .*//')
first_cmd=$(basename "$first_cmd")

# Commands that should run through devbox
devbox_commands=(
  # Ruby
  ruby irb gem bundle bundler rake rspec rails
  # JavaScript/TypeScript
  node npm npx yarn pnpm bun deno tsc tsx
  # Python
  python python3 pip pip3 pipenv poetry pytest
  # Elixir/Erlang
  elixir mix iex erl rebar3
  # Go
  go
  # Rust
  cargo rustc rustup
  # C/C++
  make cmake gcc g++ clang
  # Java/JVM
  java javac mvn gradle
)

for cmd in "${devbox_commands[@]}"; do
  if [[ "$first_cmd" == "$cmd" ]]; then
    cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"devbox.json detected — prefix this command with `devbox run --pure`."}}
EOF
    exit 0
  fi
done

exit 0
