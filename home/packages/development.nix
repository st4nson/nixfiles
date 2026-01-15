{ config, pkgs, ... }:

{
  # Programming languages, compilers, and development tools
  home.packages = with pkgs; [
    # Build tools
    gcc
    gnumake
    pre-commit
    universal-ctags

    # Nix development
    nixpkgs-fmt
    # rnix-lsp       # Nix LSP

    # JavaScript/TypeScript
    nodejs
    typescript
    typescript-language-server
    yarn
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    # playwright-test    # E2E testing (disabled - enable if needed)
    # playwright-driver  # Browser automation

    # Lua
    lua-language-server

    # Shell scripting
    shellcheck
    shfmt

    # Other languages
    cfssl
    goreleaser
    innoextract

    # Python
    uv
    # Uncomment these lines when Python development is needed.
    # Using pipenv for virtual environment management.
    #
    # pipenv
    # (python3.withPackages(ps: with ps; [
    #   isort          # Import sorting
    #   jedi           # Autocompletion
    #   jinja2         # Template engine
    #   pylint         # Linter
    #   pep8           # Style checker
    #   flake8         # Code quality
    #   pyopenssl      # OpenSSL wrapper
    #   pytest         # Testing framework
    #   pycodestyle    # PEP 8 style guide checker
    #   pyyaml         # YAML parser
    #   requests       # HTTP library
    #   tox            # Testing automation
    #   xmltodict      # XML to dict parser
    # ]))
    # python3Packages.black                # Code formatter
    # python3Packages.nose                 # Testing framework
    # python3Packages.pyflakes             # Checker
    # python3Packages.pygments             # Syntax highlighter
    # python3Packages.pyls-black           # Language server plugin
    # python3Packages.pyls-isort           # Language server plugin
    # python3Packages.pytest               # Testing
    # python3Packages.python-language-server  # LSP
  ];
}
