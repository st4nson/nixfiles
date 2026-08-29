{ ... }:
let
  substituters = [
    "https://cache.soopy.moe"
    "https://claude-code.cachix.org"
    "https://cache.numtide.com"
  ];
  trusted-public-keys = [
    "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
    "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk="
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
  ];
in
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # nixos adds cache.nixos.org at the very end so specifying that is not needed.
    # on other systems please use extra-substituters to not overwrite that.
    inherit substituters;
    trusted-substituters = substituters;
    trusted-public-keys = trusted-public-keys;
  };
}
