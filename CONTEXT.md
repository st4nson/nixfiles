# CONTEXT.md — nixfiles domain glossary

The vocabulary this repo uses for its own structure. Use these terms; don't
drift to synonyms.

## Host

A named machine output in `flake.nix` (`work`, `st4nson@linux`, `shodan`).
Each host is described by a self-contained file under `hosts/` and is the
single source of truth for that machine's identity and feature opt-ins.

## userConfig

The identity of the person a host belongs to: `username`, `fullName`, `email`,
`homeDirectory`. Declared as a module option in `modules/identity.nix` and read
as `config.userConfig`. Every host sets all four; consumers never receive it as
a module argument.

## Program

A Home Manager module under `home/programs/`, one file per program. Programs
with extensive configuration get their own file; small ones live in
`home/programs/common.nix`.

## Package bundle

A platform-gated package list under `home/packages/`: `development.nix`
(languages, build tools, LSPs), `operations.nix` (DevOps, cloud, k8s),
`utilities.nix` (general CLI).

## Feature

A host-specific opt-in module under `home/features/`, imported only by the
hosts that want it. Anything host-specific belongs here so the shared `home/`
tree stays portable.

## Overlay

A nixpkgs overlay under `overlays/`. None currently: the only one pinned
`python3Packages.okta` for `gimme-aws-creds`, both since deleted. Re-add the
directory when a real overlay appears.

## Substituter

A binary cache. The cache URLs and public keys live in `flake.nix` `nixConfig`
(for bootstrap) and `nix/substituter.nix` (for the NixOS host).