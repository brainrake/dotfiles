{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];

  networking.hostname = "calculon";

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.device = "/dev/sda";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ec38804d-ed01-4dcb-8eb0-bd9fd73b59e2";
      fsType = "ext4";
    };

  nix.maxJobs = lib.mkDefault 2;
}
