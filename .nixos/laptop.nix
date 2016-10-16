{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [ { device = "/dev/nvme0n1p6"; name = "ct"; } ];

  fileSystems."/".device = "/dev/ct/root";
  fileSystems."/".options = [ "defaults" "noatime" ];
  fileSystems."/boot".device = "/dev/nvme0n1p1";
  fileSystems."/w" = {
    device = "/dev/nvme0n1p3";
    options = [ "ro" "defaults" "umask=000" "noatime" ];
    fsType = "ntfs-3g";
  };

  networking.hostName = "eki";

  services.xserver.videoDrivers = [ "intel" ];
}
