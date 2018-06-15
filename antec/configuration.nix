{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../common-config.nix
    ];

  # Boot options
  boot = {
    initrd = {
      availableKernelModules =  [
        "ext4"
        "hid_generic"
        "hid_microsoft"
      ];

      luks.devices = [
        {
          name = "luksroot";
          device = "/dev/sda2";
          preLVM = true;
          allowDiscards = true;
        }
      ];
    };

    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;

      grub = {
        #configurationName = "Stable 1.2.3"
        configurationLimit = 25;
      };
    };

    cleanTmpDir = true;
  };

  # Services to enable:
  services.openssh.enable = true;

  # Networking setup
  networking = {
    hostName = "st4nson-dev";
    dhcpcd.denyInterfaces = [ "enp3s0" ];
    firewall.trustedInterfaces = [ "docker0" ];
  };

  # Setup display and window maanger
  services.xserver = {
    videoDrivers = [ "intel" ];
  };

  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];

  virtualisation = {
    virtualbox.host.enable = true;
  };

  # User account
  users.extraUsers.st4nson = {
    extraGroups  = [
      "vboxusers"
    ];
  };
}
