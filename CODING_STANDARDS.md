# CODING_STANDARDS.md — Nix conventions for nixfiles

## Module signature

```nix
{ config, pkgs, lib, ... }:

{
  # ...
}
```

Host identity is read as `config.userConfig`, declared in
`modules/identity.nix`.

## Conventions

- Indent 2 spaces, no trailing whitespace
- Multi-line attribute sets for >1 item; single-line OK for 1
- `inherit` for pass-through: `inherit (lib) optionalString;`
- Imports: relative paths within the same subtree
- Conditional config: `lib.mkIf pkgs.stdenv.is{Darwin,Linux}`

## Package lists

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

## Naming

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