# Darwin Custom Modules

This directory contains custom reusable modules for nix-darwin.

Custom modules allow you to define reusable configuration patterns that can be shared across multiple hosts.

## Usage

Create module files in this directory and import them in your host configuration or darwin/default.nix.

Example:
```nix
# modules/darwin/my-module.nix
{ config, lib, pkgs, ... }:

{
  options = {
    # Define options here
  };
  
  config = {
    # Define configuration here
  };
}
```
