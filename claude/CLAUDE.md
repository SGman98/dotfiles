# Instructions

## Environment

- Shell is fish, editor is Neovim, language runtimes and tools come from mise

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
