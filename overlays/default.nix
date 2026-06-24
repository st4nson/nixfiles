# Nixpkgs overlays
# Use overlays to modify or add packages to nixpkgs

[
  # Pin python3Packages.okta to 2.9.13 so gimme-aws-creds builds.
  # See ./pkgs/python-okta-2.nix for full context.
  (final: prev: {
    pythonPackagesExtensions = (prev.pythonPackagesExtensions or [ ]) ++ [
      (pyfinal: pyprev: {
        okta = pyfinal.callPackage ./pkgs/python-okta-2.nix { };
      })
    ];
  })
]
