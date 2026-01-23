# nixfiles

## Hosts

| Output                                 | Type          |
|----------------------------------------|---------------|
| `.#darwinConfigurations.work`          | nix-darwin    |
| `.#homeConfigurations."st4nson@linux"` | standalone HM |

## Quick start

### macOS (darwin)

```bash
# Build only
darwin-rebuild build --flake '.#work'

# Build + activate
sudo darwin-rebuild switch --flake '.#work'

# Or use the bundled aliases (after first activation):
nix-build-work
nix-switch-work
```

### Linux (standalone Home Manager)

```bash
home-manager switch --flake '.#st4nson@linux'
```

### Sanity checks

```bash
nix flake check                                                       # validate flake
nix eval '.#homeConfigurations."st4nson@linux".config.home.username'  # eval-only
darwin-rebuild build --flake '.#work' --show-trace                    # debug builds
```
