# Home Manager Custom Modules

This directory contains custom reusable modules for home-manager.

Custom modules allow you to define reusable configuration patterns that can be shared across multiple users or hosts.

## Usage

Create module files in this directory and import them in your home configuration.

Example:
```nix
# modules/home-manager/my-module.nix
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
