# AGENTS.md - AI Agent Guidelines for nixfiles

This document provides guidelines for AI coding agents working in this repository.

## Project Overview

This is a personal Nix configuration repository for managing macOS (nix-darwin) and
Linux (NixOS + Home Manager) systems. The entire configuration is written in the
Nix expression language.

**Primary Technologies:**
- Nix (primary language)
- Lua (Neovim configuration)
- Shell/Bash (zsh functions, sketchybar plugins)
- YAML/TOML (application configs)

## Build Commands

### macOS (nix-darwin)

```bash
# Build without activating (dry-run/test)
darwin-rebuild build --flake ".#default"

# Build and activate
sudo darwin-rebuild switch --flake ".#default"

# Build with verbose output for debugging
darwin-rebuild build --flake ".#default" --show-trace
```

### Home Manager (standalone)

```bash
# Build without activating
home-manager build --flake ".#username"

# Build and activate
home-manager switch --flake ".#username"
```

### Flake Management

```bash
# Update all flake inputs
nix flake update

# Update a specific input
nix flake lock --update-input nixpkgs

# Check flake syntax
nix flake check

# Show flake metadata
nix flake metadata
```

### Testing and Validation

There is no traditional test suite. Validation is done by building:

```bash
# Validate configuration syntax and evaluate
darwin-rebuild build --flake ".#default"

# Format Nix files
nixpkgs-fmt **/*.nix

# Check shell scripts
shellcheck dotfiles/sketchybar/plugins/*.sh
shellcheck dotfiles/zsh/zsh_functions
```

## Repository Structure

```
nixfiles/
├── flake.nix              # Root flake - entry point
├── flake.lock             # Locked dependencies
├── .local.nix             # Machine-specific config (gitignored, force-added)
├── .local.nix.example     # Template for .local.nix
├── machines/              # Abstract machine profiles
│   ├── work.nix           # Work machine settings
│   └── personal.nix       # Personal machine settings
├── darwin/                # macOS-specific modules
│   ├── default.nix        # Module coordinator
│   ├── system.nix         # System preferences
│   ├── services.nix       # yabai, skhd, sketchybar
│   └── fonts.nix          # Font configuration
├── home/                  # Home Manager configuration
│   ├── default.nix        # Entry point
│   ├── programs/          # Program configs (git, zsh, nvim, tmux)
│   ├── packages/          # Package collections by category
│   └── profiles/          # User profiles (minimal, development, full)
├── overlays/              # Nixpkgs overlays
└── dotfiles/              # Raw config files (alacritty, neovim, sketchybar)
```

## Code Style Guidelines

### Nix File Structure

Every Nix module should follow this structure:

```nix
{ config, pkgs, lib, userConfig, hostConfig, ... }:

{
  # Module implementation
}
```

### Imports Pattern

Use relative paths for imports within the same tree:

```nix
imports = [
  ./system.nix
  ./services.nix
  ../programs/git.nix
];
```

### Package Lists

Use `with pkgs;` for package lists, with comments for categories:

```nix
home.packages = with pkgs; [
  # Build tools
  gcc
  gnumake

  # JavaScript/TypeScript
  nodejs
  typescript
];
```

### Naming Conventions

- **Files:** lowercase with hyphens or underscores (`system.nix`, `development.nix`)
- **Attributes:** camelCase for custom options (`userConfig`, `hostConfig`)
- **Host names:** Use machine identifier (e.g., `AP7TXJWN60C1AE`)

### Formatting Rules

- 2-space indentation
- No trailing whitespace
- Attribute sets with multiple items use multi-line format
- Single-item attribute sets can be inline
- Use `inherit` for passing through attributes

```nix
# Good - inherit for pass-through
let
  inherit (lib) optionalString;
  inherit (pkgs.stdenv) isDarwin isLinux;
in

# Good - multi-line for clarity
system.defaults.dock = {
  autohide = true;
  orientation = "bottom";
  tilesize = 64;
};

# Good - inline for simple values
services.yabai.enable = true;
```

### Comments

- Use `#` for single-line comments
- Place comments above the code they describe
- Document non-obvious configuration choices

```nix
# Lazy-load kubectl completions to improve startup time
kubectl() {
  unfunction kubectl 2>/dev/null
  source <(command kubectl completion zsh)
  kubectl "$@"
}
```

### Let Bindings

Use `let...in` for local variables and complex computations:

```nix
let
  sysUsername = userConfig.username;
  hostname = hostConfig.hostname;
  nixfilesPath = "${config.home.homeDirectory}/git/nixfiles";
in
{
  # Use variables here
}
```

### Conditional Imports

Use `builtins.pathExists` for optional imports:

```nix
let
  privateUsers = if builtins.pathExists ./private.nix
                 then import ./private.nix
                 else { users = {}; };
in
```

### Error Handling

- Nix is purely functional; errors are handled at evaluation time
- Use `assert` for preconditions
- Use `throw` or `abort` for unrecoverable errors
- Prefer `lib.mkIf` for conditional configuration

## Adding New Components

### New Program

1. Create `home/programs/myprogram.nix`
2. Import in the appropriate profile (`home/profiles/*.nix`)
3. Add packages to `home/packages/*.nix` if needed

### New Package Category

Add to appropriate file in `home/packages/`:
- `development.nix` - Programming languages, build tools
- `operations.nix` - DevOps, cloud, container tools
- `utilities.nix` - CLI utilities
- `gui.nix` - GUI applications (Linux)

### New Host

1. Create a new machine profile in `machines/` if needed (e.g., `machines/server.nix`)
2. On the new machine, copy `.local.nix.example` to `.local.nix`
3. Edit `.local.nix` with machine-specific values (hostname, username, email, etc.)
4. Run `git add -f .local.nix` to track the file (it's gitignored by default)
5. Build with `darwin-rebuild switch --flake '.#default'`

### New User

User configuration is now part of `.local.nix`. To set up a new user:
1. Edit `.local.nix` and update username, email, fullName, etc.
2. The flake reads these values directly from `.local.nix`

## Private Configuration

Sensitive data goes in `.local.nix` which is gitignored but force-added per machine:
- `.local.nix` - Machine-specific config (hostname, username, email, etc.)
- `.local.nix.example` - Template showing required fields (committed)

The flake merges `.local.nix` with abstract machine profiles from `machines/*.nix`.

## Common Patterns

### Platform-specific code

```nix
let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  home.packages = with pkgs; [
    # Common packages
  ] ++ lib.optionals isLinux [
    # Linux-only packages
  ] ++ lib.optionals isDarwin [
    # macOS-only packages
  ];
}
```

### Reading external files

```nix
extraLuaConfig = builtins.readFile ../../dotfiles/neovim/init.lua;
home.file.".config/nvim/lua".source = ../../dotfiles/neovim/lua;
```

### Shell aliases with dynamic paths

```nix
shellAliases = {
  nix-darwin-switch = "pushd ${nixfilesPath}; sudo darwin-rebuild switch --flake \".#${hostname}\"; popd";
};
```

## Important Notes

- Always test builds before committing: `darwin-rebuild build --flake ".#default"`
- Keep `flake.lock` in version control
- Never commit secrets; use `private.nix` files
- Run `nix flake update` periodically to update dependencies
- Use `--show-trace` flag for debugging build failures
