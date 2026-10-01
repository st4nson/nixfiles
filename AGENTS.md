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

# Activate
sudo darwin-rebuild switch --flake '.#work'           # macOS
home-manager switch --flake '.#st4nson@linux'         # Linux

# Debug / lint
darwin-rebuild build --flake '.#work' --show-trace
nixfmt **/*.nix
shellcheck dotfiles/sketchybar/plugins/*.sh dotfiles/zsh/zsh_functions

# Flake inputs
nix flake update
nix flake lock --update-input nixpkgs
```

No test suite — validation is a successful build. Commit `flake.lock`.

## Repository layout

```
nixfiles/
├── flake.nix              # named-host outputs only
├── hosts/
│   ├── work.nix           # darwin: Work MacBook
│   ├── linux.nix          # standalone HM: st4nson@linux
│   ├── shodan.nix         # NixOS: Shodan (apple-t2)
│   └── shodan-hw-cfg.nix  # Shodan hardware profile
├── darwin/                # macOS modules (system, services, fonts)
├── home/
│   ├── default.nix        # HM entry; imports programs + packages
│   ├── programs/          # one file per program
│   ├── packages/          # bundles: development, operations, utilities
│   └── features/          # host-specific opt-ins
│       ├── nike-work.nix  # AWS env, KUBECACHEDIR, work-host aliases
│       └── linux-extras.nix # Linux CLI extras
├── modules/               # cross-system option modules (identity.nix)
├── nix/                   # NixOS fragments (substituter.nix)
├── overlays/              # nixpkgs overlays (default.nix exports; pkgs/ pins)
└── dotfiles/              # raw configs, live-symlinked where applicable
```

The overlay in `overlays/pkgs/python-okta-2.nix` pins `okta` to 2.9.13 so
`gimme-aws-creds` builds. Don't remove it without checking that package.

## Code style

### Module signature

```nix
{ config, pkgs, lib, ... }:

{
  # ...
}
```

Host identity is read as `config.userConfig`, declared in
`modules/identity.nix`.

### Conventions

- Indent 2 spaces, no trailing whitespace
- Multi-line attribute sets for >1 item; single-line OK for 1
- `inherit` for pass-through: `inherit (lib) optionalString;`
- Imports: relative paths within the same subtree
- Conditional config: `lib.mkIf pkgs.stdenv.is{Darwin,Linux}`

### Package lists

```nix
home.packages = with pkgs; [
  # Category
  pkg-a
  pkg-b
] ++ lib.optionals pkgs.stdenv.isDarwin [
  darwin-only-pkg
] ++ lib.optionals pkgs.stdenv.isLinux [
  linux-only-pkg
];
```

### Naming

| Element    | Convention                                |
|------------|-------------------------------------------|
| Files      | lowercase, hyphens or underscores         |
| Attributes | camelCase (`userConfig`, `homeDirectory`) |
| Hostnames  | Machine identifier                        |

## Adding components

**New program** — create `home/programs/<name>.nix`, add to `imports` in
`home/default.nix`.

**New package** — add to the right bundle in `home/packages/`
(`development.nix` for languages/build tools/LSPs, `operations.nix` for
DevOps/cloud/k8s, `utilities.nix` for general CLI). Gate per-platform with
`lib.optionals pkgs.stdenv.is{Darwin,Linux}`.

**New host:**

1. Copy `hosts/work.nix` (darwin), `hosts/linux.nix` (HM), or
   `hosts/shodan.nix` (NixOS)
2. Fill in `userConfig` (and `hostConfig`/system for darwin)
3. Wire in `flake.nix`:
   - darwin: `darwinConfigurations.<name> = darwin.lib.darwinSystem { ... }`
   - HM: `homeConfigurations."<user>@<host>" = home-manager.lib.homeManagerConfiguration { ... }`
   - NixOS: `nixosConfigurations.<name> = nixpkgs.lib.nixosSystem { ... }`

**New feature** — add `home/features/<name>.nix`, opt-in only from
`hosts/<host>.nix` imports.

## Live-symlinked dotfiles

Neovim (`home/programs/nvim.nix`) and Ghostty (`home/programs/ghostty.nix`)
use `config.lib.file.mkOutOfStoreSymlink` to point at
`dotfiles/{neovim,ghostty}/` directly. Edits take effect immediately, no
rebuild.

`lazy.nvim` writes `lazy-lock.json` through the symlink into
`dotfiles/neovim/lazy-lock.json` — commit it for cross-host plugin
reproducibility.

## External files

```nix
# Embed file content
initLua = builtins.readFile ../../dotfiles/neovim/init.lua;

# Live symlink (writable, edits apply without rebuild)
xdg.configFile."nvim".source =
  config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/git/nixfiles/dotfiles/neovim";

# Static symlink (read-only via Nix store, requires rebuild)
home.file.".config/foo".source = ../../dotfiles/foo;
```

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