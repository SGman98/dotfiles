# Instructions

## Environment

- Interactive shell is fish, editor is Neovim

## Responses

- Be concise: answer first, no preamble, recap or filler
- Grammar can be dropped if meaning stays clear; keep code, commands,
  paths and errors exact

## Project stack

- Install runtimes and CLIs through mise, never system package managers,
  nvm, pyenv, sdkman or similar
- Python: always uv (`uv init`, `uv add`, `uv run`). No pip, venv, poetry
  or requirements.txt unless the project already uses them
- Node: latest version, and latest versions of dependencies when adding them
- Java: Temurin JDK with Maven
- In an existing project, follow the tooling it already uses

## Scripting

- Write scripts in bash, never fish: most of them end up running on servers
  where only bash exists. Commands for me to paste can be fish
- Start with `#!/usr/bin/env bash` and `set -euo pipefail`
- Assume a stock server: no mise, no tools beyond coreutils and what the
  distro ships, unless the script installs them itself

## Git commits

- Use Conventional Commits with a unicode gitmoji after the colon:
  `type(scope): <gitmoji> summary`
  - Examples: `feat(api): ✨ add login endpoint`,
    `fix(readme): 🐛 fix broken link`, `docs: 📝 update setup guide`,
    `refactor(db): ♻️ split migrations`, `refactor: 🚚 move files`,
    `build: 📦 update compiled output`, `chore(config): 🔧 update lint rules`,
    `test: ✅ add parser cases`
  - Summary in lowercase imperative, no trailing period; scope optional
  - Add a wrapped body explaining what and why when the change isn't trivial

## Verification

- Before reporting work as done, run the project's own lint/format/test
  commands and report any failures

## Code comments

- Don't add comments by default. Add one only when it tells the reader
  something the code can't: a non-obvious reason, a constraint, a gotcha.
  Never restate what the code does or narrate the change (the commit message
  covers that)
