# Verify by building on the target machine; no `checks` output, no CI

We verify Nix changes by building them on the machine they target —
`home-manager build` / `nixos-rebuild build` on shodan, `darwin-rebuild build`
on the Mac — instead of adding a flake `checks` output or CI. A `checks` output
would duplicate those builds for the Linux hosts, and its only unique value
(evaluating the darwin config while on Linux) does not justify a second
verification path. Rejected: `checks.x86_64-linux.*` for the HM and shodan
builds, and a `nixfmt` check (the commit hook already gates staged files).

## Consequences

A cross-system config error is discovered at switch time, not at commit time.
Concretely: `home/packages/development.nix` installs a Python env whose
`pandas` pulls `arrow-cpp`, which nixpkgs marks broken on x86_64-darwin; Home
Manager's darwin fonts module forces all `home.packages`, so the darwin build
fails while `nix flake check` reports success. This is accepted: the darwin
config is fixed when the Mac is next used.
