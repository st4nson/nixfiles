# Nixpkgs overlays
# Use overlays to modify or add packages to nixpkgs

# Example overlay:
# self: super: {
#   # Override existing package
#   mypackage = super.mypackage.overrideAttrs (old: {
#     version = "1.2.3";
#   });
#
#   # Add new package
#   custom-tool = super.callPackage ./packages/custom-tool.nix { };
# }

[
  # Add overlays here
]
