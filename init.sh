#!/usr/bin/env bash

set -e

git submodule init
git submodule update

HOME_VER=21.11

nix-channel --add https://github.com/rycee/home-manager/archive/release-$HOME_VER.tar.gz home-manager
nix-channel --update

reset

mkdir -p ~/.config/nixpkgs
ln -fs "$(pwd)"/nixpkgs-config.nix ~/.config/nixpkgs/common.nix
ln -fs "$(pwd)"/home.nix ~/.config/nixpkgs/home.nix

nix-shell '<home-manager>' -A install

echo "Init complete."
