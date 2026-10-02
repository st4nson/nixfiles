# AGENTS.md — AI Agent Guidelines for nixfiles

## Project overview

Personal Nix config for macOS (nix-darwin + Home Manager), Linux (standalone
Home Manager), and one NixOS host. Single user, named-host outputs, no profile
system.

**Stack:** Nix (primary), Lua (Neovim), Shell/zsh, YAML/TOML (app configs)

## Build / test

```bash
# Validate (before committing)
nix flake check                                       # all outputs
darwin-rebuild build --flake '.#work'                 # darwin host
nix eval '.#homeConfigurations."st4nson@linux".config.home.username'
# Linux host: eval-only without a Linux builder.

# Debug / lint
darwin-rebuild build --flake '.#work' --show-trace
nixfmt **/*.nix
shellcheck dotfiles/sketchybar/plugins/*.sh dotfiles/zsh/zsh_functions

# Flake inputs
nix flake update
nix flake lock --update-input nixpkgs
```

No test suite — validation is a successful build. Commit `flake.lock`.

Commits are hook-gated: a repo-local opencode hook runs `nixfmt --check` and
`shellcheck` on changed files, and `nix flake check` when `.nix` files are
staged.

## Coding standards

**Read `CODING_STANDARDS.md` before adding or editing Nix.** It carries the
module signature, style conventions, package-list pattern, naming, how to add
programs/packages/hosts/features, and external-file handling.

## Live-symlinked dotfiles

Neovim (`home/programs/nvim.nix`) and Ghostty (`home/programs/ghostty.nix`)
use `config.lib.file.mkOutOfStoreSymlink` to point at
`dotfiles/{neovim,ghostty}/` directly. Edits take effect immediately, no
rebuild.

`lazy.nvim` writes `lazy-lock.json` through the symlink into
`dotfiles/neovim/lazy-lock.json` — commit it for cross-host plugin
reproducibility.

## Agent skills

### Issue tracker

Issues and specs live as local markdown under `.scratch/<feature>/`. See
`docs/agents/issue-tracker.md`.

### Triage labels

Five canonical triage roles map 1:1 to their label strings. See
`docs/agents/triage-labels.md`.

### Domain docs

Single-context: `CONTEXT.md` + `docs/adr/` at the repo root. See
`docs/agents/domain.md`.