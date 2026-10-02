# Verify by building on the target machine; eval-only darwin check, no CI

We verify Nix changes by building them on the machine they target —
`home-manager build` / `nixos-rebuild build` on shodan, `darwin-rebuild build`
on the Mac — instead of adding CI. For the Linux hosts a `checks` output would
duplicate those builds, so we add none for them.

The one exception is `checks.x86_64-linux.darwin-eval`: it forces every darwin
toplevel `drvPath` with `builtins.deepSeq` and builds nothing. It does not
duplicate the target-machine build; its unique value is evaluating the darwin
config while on Linux, which is what previously let a broken darwin package
reach `nix flake check` unnoticed. Rejected: `checks.x86_64-linux.*` for the HM
and shodan builds, and a `nixfmt` check (the commit hook already gates staged
files).

## Consequences

An eval-time cross-system config error is now caught by `nix flake check` on
Linux, not only at switch time on the Mac. Concretely:
`home/packages/development.nix` installed a Python env whose `pdfplumber`
pulled `arrow-cpp`, which nixpkgs marks broken on x86_64-darwin; `darwin-eval`
now fails on Linux when such a broken package enters the darwin
`home.packages`.

Residual risk: a darwin failure that only appears at build time — not eval
time — is still discovered at switch time, so this ADR still requires building
on the target machine before switching.
