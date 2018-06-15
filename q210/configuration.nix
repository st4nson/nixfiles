{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./boot-config.nix
#      ./network-config.nix
      ./../common-config.nix
    ];

  # TODO
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Networking setup
  networking = {
    hostName = "st4nson-q210";
    firewall.trustedInterfaces = [ "docker0" ];
    wireless.enable = true;
  };

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
}
