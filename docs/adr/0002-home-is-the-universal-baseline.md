# `home/` is the universal baseline; platform and host concerns are features

`home/` is imported by every host, so it is the universal baseline: no
darwin-only extras, no host/work concerns, and no platform-conditional *config
blocks*. Platform-specific Home Manager config lives in `home/features/` and is
imported by the hosts that want it.

Per-package `lib.optionals pkgs.stdenv.is{Darwin,Linux}` and per-program
platform handling — ghostty's config path, atuin's daemon toggle — stay in
`home/`. The boundary test for the next reader:

- "Does this express how a cross-platform program behaves per platform?" →
  keep in `home/programs/`.
- "Is this a darwin-only extra or a host/work concern?" → move to
  `home/features/`.

Rejected: the minimal reading, in which `home/` may keep `lib.mkIf isDarwin`
config blocks as long as they are gated. That leaves the ambiguity that
produced the original leak — a darwin-only extra or a host concern hides
behind a conditional instead of being an explicit opt-in from the host that
wants it.

## Consequences

Adding a darwin host now means importing `home/features/darwin.nix` (and any
other platform feature) from that host; forgetting to do so silently drops the
config. The shared tree no longer grows platform branches, so Linux and darwin
evaluate the same baseline. Per-program platform handling is still allowed and
expected — the rule targets darwin-only extras and host/work concerns, not the
platform behaviour of a program that legitimately differs.
