{ ... }:
let
  substituters = [
    "https://cache.soopy.moe"
    "https://cache.numtide.com"
  ];
  trusted-public-keys = [
    "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
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
