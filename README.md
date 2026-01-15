# Nixfiles - Nix Configuration for macOS and Linux

A modular, well-documented Nix configuration for managing macOS (nix-darwin) and Linux (NixOS + Home Manager) systems with a focus on maintainability, reusability, and best practices.

## Features

✨ **Modular Architecture**: Clean separation of concerns with logical module organization
🔧 **Multi-User Support**: Easy configuration for different users and hosts
📦 **Package Collections**: Organized by category (development, operations, utilities, GUI)
👤 **User Profiles**: Composable profiles (minimal, development, full)
🎯 **Type Safety**: Comprehensive type checking with validation
⚡ **Performance Optimized**: Fast shell startup with lazy-loading
📚 **Well Documented**: Inline documentation and examples throughout

## Repository Structure

```
nixfiles/
├── flake.nix              # Root flake configuration
├── flake.lock             # Flake dependencies lock file
├── README.md              # This file
│
├── .local.nix             # Machine-specific config (gitignored, force-added per machine)
├── .local.nix.example     # Template for .local.nix
│
├── machines/              # Abstract machine profiles
│   ├── work.nix           # Work machine settings
│   └── personal.nix       # Personal machine settings
│
├── darwin/                # Darwin (macOS) modules
│   ├── default.nix        # Module coordinator
│   ├── system.nix         # System preferences and settings
│   ├── services.nix       # Services (yabai, skhd, sketchybar)
│   └── fonts.nix          # Font configuration
│
├── home/                  # Home Manager configuration
│   ├── default.nix        # Home Manager entry point
│   │
│   ├── programs/          # Program-specific configurations
│   │   ├── alacritty.nix  # Alacritty terminal
│   │   ├── awesome.nix    # AwesomeWM (Linux only)
│   │   ├── common.nix     # Shared configurations (bat, direnv, fzf)
│   │   ├── git.nix        # Git configuration
│   │   ├── go.nix         # Go development setup
│   │   ├── nvim.nix       # Neovim with plugins
│   │   ├── taskwarrior.nix # Task management
│   │   ├── tmux.nix       # Tmux with plugins
│   │   └── zsh.nix        # Zsh with oh-my-zsh
│   │
│   ├── packages/          # Package collections by category
│   │   ├── development.nix # Programming languages and tools
│   │   ├── operations.nix  # DevOps and cloud tools
│   │   ├── utilities.nix   # CLI utilities
│   │   └── gui.nix         # GUI applications (Linux)
│   │
│   └── profiles/          # User profiles
│       ├── minimal.nix     # Essential tools only
│       ├── development.nix # Full development environment
│       └── full.nix        # Everything including GUI
│
├── modules/               # Custom reusable modules (future)
│   ├── darwin/
│   └── home-manager/
│
├── overlays/              # Nixpkgs overlays
│   └── default.nix
│
└── dotfiles/              # Raw configuration files
    ├── alacritty/
    ├── awesome/
    ├── catppuccin/
    ├── neovim/
    ├── sketchybar/
    └── zsh/
```

## Quick Start

### Prerequisites

1. **Install Nix** with flakes enabled:
   ```bash
   # macOS or Linux
   curl -L https://nixos.org/nix/install | sh -s -- --daemon

   # Enable flakes in ~/.config/nix/nix.conf
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   ```

2. **macOS only**: Install nix-darwin:
   ```bash
   nix run nix-darwin -- switch --flake ~/git/nixfiles#default
   ```

### Building the Configuration

#### macOS (nix-darwin)
```bash
# Build without activating
darwin-rebuild build --flake ".#default"

# Build and activate
sudo darwin-rebuild switch --flake ".#default"
```

#### Linux (NixOS)
```bash
# Build without activating
nixos-rebuild build --flake ".#hostname"

# Build and activate
sudo nixos-rebuild switch --flake ".#hostname"
```

#### Home Manager only
```bash
# Build without activating
home-manager build --flake ".#user@hostname"

# Build and activate
home-manager switch --flake ".#user@hostname"
```

### Shell Aliases

The configuration includes convenient aliases (defined in `home/programs/zsh.nix`):

```bash
# Darwin (macOS) aliases
nix-darwin-build    # Build darwin configuration without switching
nix-darwin-switch   # Build and switch darwin configuration

# Home Manager aliases
nix-home-build      # Build home-manager configuration without switching
nix-home-switch     # Build and switch home-manager configuration
```

## Configuration

### Machine-Specific Configuration (.local.nix)

Each machine has its own `.local.nix` file containing sensitive/machine-specific data.
This file is gitignored but force-added per machine.

To set up a new machine:
1. Copy `.local.nix.example` to `.local.nix`
2. Fill in your machine-specific values
3. Run `git add -f .local.nix` to track it

Example `.local.nix`:
```nix
{
  # Which machine profile to use (must match a file in machines/)
  machine = "work";  # or "personal"

  # Machine identity
  hostname = "MyMacBook";
  computerName = "My MacBook Pro";

  # User identity
  username = "jdoe";
  fullName = "John Doe";
  email = "john@example.com";
  homeDirectory = "/Users/jdoe";

  # Git/GitHub identities (optional, defaults to username)
  gitUser = "johndoe";
  githubUser = "johndoe";
}
```

### Machine Profiles (machines/)

Abstract machine profiles define platform settings and defaults.
Sensitive values come from `.local.nix`.

Example `machines/work.nix`:
```nix
{
  system = "aarch64-darwin";
  platform = "darwin";
  shell = "zsh";
  profile = "development";  # Options: minimal, development, full
}
```

### Profiles

Three profiles are available:

1. **minimal**: Essential tools only (suitable for servers)
   - Basic CLI utilities (fd, ripgrep, jq, htop, wget)
   - Git and basic shell configuration

2. **development**: Full development environment
   - All programming languages and tools
   - DevOps and cloud tools (kubectl, docker, terraform)
   - Enhanced CLI utilities
   - Terminal setup (alacritty, tmux, zsh with plugins)

3. **full**: Complete setup with GUI
   - Everything from development profile
   - GUI applications
   - Desktop environment (AwesomeWM on Linux)
   - Task management tools

## Adding a New Host

1. **Create `.local.nix`** on the new machine:
   ```bash
   cp .local.nix.example .local.nix
   # Edit .local.nix with your machine-specific values
   ```

2. **Choose or create a machine profile**:
   - Use existing: set `machine = "work";` or `machine = "personal";`
   - Or create new profile in `machines/myprofile.nix`

3. **Track the local config**:
   ```bash
   git add -f .local.nix
   ```

4. **Build**:
   ```bash
   darwin-rebuild build --flake ".#default"
   ```

## Adding a New User

User configuration is part of `.local.nix`. To set up for a different user:

1. **Edit `.local.nix`** with the new user's values:
   ```nix
   {
     machine = "personal";
     hostname = "MyMacBook";
     username = "newuser";
     fullName = "New User";
     email = "newuser@example.com";
     homeDirectory = "/Users/newuser";
   }
   ```

2. **Rebuild** - the configuration automatically uses the new user info:
   ```bash
   sudo darwin-rebuild switch --flake ".#default"
   ```

## Adding a New Program

1. **Create program module** in `home/programs/`:
   ```nix
   # home/programs/myprogram.nix
   { config, pkgs, lib, ... }:

   {
     programs.myprogram = {
       enable = true;
       # configuration here
     };
   }
   ```

2. **Import in profile** (e.g., `home/profiles/development.nix`):
   ```nix
   imports = [
     ../programs/myprogram.nix
   ];
   ```

3. **Add packages** if needed in appropriate package file:
   - `home/packages/development.nix` for dev tools
   - `home/packages/operations.nix` for ops tools
   - `home/packages/utilities.nix` for utilities
   - `home/packages/gui.nix` for GUI apps

## Package Categories

### Development (`home/packages/development.nix`)
Programming languages, build tools, language servers, and development utilities:
- Languages: Node.js, Go, Rust, etc.
- Build tools: gcc, cmake, ninja
- Language servers: nixd, gopls
- Version control: git, gh

### Operations (`home/packages/operations.nix`)
DevOps, cloud, container, and infrastructure tools:
- Container tools: docker, kubectl, helm
- Cloud CLIs: awscli2
- Monitoring: k9s
- SSH utilities: sshpass

### Utilities (`home/packages/utilities.nix`)
General-purpose CLI tools and utilities:
- Search: ripgrep, fd
- JSON/YAML: jq, yq-go
- Compression: unzip, xz
- Network: curl, wget, netcat
- System: htop, neofetch

### GUI (`home/packages/gui.nix`)
Graphical applications (Linux-specific):
- Browsers: firefox
- Media: vlc
- Communication: discord
- Productivity: libreoffice

## Troubleshooting

### Build Fails

1. **Update flake inputs**:
   ```bash
   nix flake update
   ```

2. **Clear build cache**:
   ```bash
   sudo rm -rf /nix/var/nix/gcroots/auto/*
   sudo nix-collect-garbage -d
   ```

3. **Check for errors**:
   ```bash
   darwin-rebuild build --flake ".#default" --show-trace
   ```

### Slow Shell Startup

The configuration includes lazy-loading for kubectl and helm completions. If shell startup is still slow:

1. Check zsh plugins in `home/programs/zsh.nix`
2. Profile startup: `zsh -i -c exit` with timing
3. Disable plugins one by one to identify the culprit

### Home Manager Issues

1. **State version mismatch**:
   - Check `home.stateVersion` in `home/default.nix`
   - Should match your first installation version

2. **File conflicts**:
   - Home Manager can't manage files that already exist
   - Back up and remove conflicting files
   - Let Home Manager recreate them

### macOS-Specific Issues

1. **Yabai not working**:
   - Check SIP status: `csrutil status`
   - Yabai requires SIP to be partially disabled
   - See: https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection

2. **Sketchybar not showing**:
   - Check if service is running: `brew services list`
   - Restart: `brew services restart sketchybar`

## Best Practices

### Version Control
- Keep flake.lock in version control
- Use atomic commits for each change
- Tag working configurations
- Test before pushing

### Security
- Never commit secrets to the repository
- Consider using agenix or sops-nix for secrets
- Keep SSH keys outside of Nix store
- Review packages before adding

### Performance
- Use lazy-loading for slow completions
- Profile shell startup periodically
- Clean up unused generations
- Run garbage collection regularly

### Maintenance
- Update flake inputs monthly
- Review deprecated options
- Test builds before switching
- Keep documentation current

## Advanced Features

### Overlays

Custom package modifications can be added to `overlays/default.nix`:
```nix
final: prev: {
  # Override package version
  mypackage = prev.mypackage.overrideAttrs (old: {
    version = "1.2.3";
    src = final.fetchFromGitHub { ... };
  });
}
```

### Custom Modules

Reusable modules can be created in `modules/`:
```nix
# modules/home-manager/my-module.nix
{ config, lib, pkgs, ... }:

with lib;

{
  options.my.module = {
    enable = mkEnableOption "my custom module";
  };

  config = mkIf config.my.module.enable {
    # module configuration
  };
}
```

### Multiple Hosts

The configuration supports multiple hosts. Each machine maintains its own `.local.nix`:
1. Copy `.local.nix.example` to `.local.nix` on the new machine
2. Fill in machine-specific values
3. Choose appropriate machine profile (work, personal, or create new)
4. Run `git add -f .local.nix` to track it
5. Build with `darwin-rebuild switch --flake ".#default"`

## Resources

- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [nix-darwin Manual](https://github.com/LnL7/nix-darwin)
- [Nix Pills](https://nixos.org/guides/nix-pills/)

## Contributing

This is a personal configuration repository, but suggestions and improvements are welcome:
1. Open an issue to discuss changes
2. Submit a pull request with clear description
3. Follow existing code style and conventions
4. Test changes before submitting

## License

This configuration is available under the MIT License. Feel free to use and adapt for your own needs.

## Acknowledgments

- [NixOS Community](https://nixos.org/community/)
- [Home Manager Project](https://github.com/nix-community/home-manager)
- [nix-darwin Project](https://github.com/LnL7/nix-darwin)

---

**Note**: This configuration is actively maintained and follows modern Nix best practices. It has been refactored through multiple phases to improve organization, maintainability, and documentation.

For detailed refactoring history and implementation details, see the `PHASE*_PROGRESS.md` files.
