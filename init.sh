#!/usr/bin/env bash

nix-channel --add https://github.com/rycee/home-manager/archive/release-19.09.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

mkdir ~/.config/nixpkgs
ln -s ./home.nix ~/.config/nixpkgs/home.nix

echo "Init complete - start new shell and run 'home-manager switch'"
