{ config, lib, pkgs, ... }:

{
  imports =
  [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
  {
    device = "/dev/disk/by-uuid/af96a08e-74dd-4ac8-9322-d50febe967b5";
    fsType = "ext4";
  };

  fileSystems."/boot" =
  {
    device = "/dev/disk/by-uuid/8172-0F0A";
    fsType = "vfat";
  };

  fileSystems."/home" =
  {
    device = "/dev/disk/by-uuid/0afdc2ad-4f4f-4966-9d79-9b0baf81b16a";
    fsType = "ext4";
  };

  swapDevices =
  [
    { device = "/dev/disk/by-uuid/7dd4db3f-da6a-4abd-b4a5-bc8d4dcfe5c4"; }
  ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = "powersave";
}
