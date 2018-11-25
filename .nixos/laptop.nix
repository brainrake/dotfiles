{ config, lib, pkgs, ... }:
{
  imports = [./common.nix ./graphical.nix ]; # ./musnix ];

  # musnix = {
  #   enable = false; # true;
  #   soundcardPciId = "00:1f.3";
  #   kernel = {
  #     optimize = true;
  #     realtime = true;
  #     latencytop = true;
  #   };
  #   rtirq.enable = true;
  # };
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [ { device = "/dev/nvme0n1p6"; name = "ct"; } ];

  fileSystems."/".device = "/dev/ct/root";
  fileSystems."/".options = [ "defaults" "noatime" ];
  fileSystems."/boot".device = "/dev/nvme0n1p1";
  fileSystems."/w" = {
    device = "/dev/nvme0n1p3";
    options = [ "rw" "defaults" "umask=000" "noatime" ];
    fsType = "ntfs-3g";
  };

  services.xserver.videoDrivers = [ "intel" ]; # "nvidia" ];

  networking.hostName = "eki";

  # programs.adb.enable = true;

  services.keybase.enable = true;
  services.kbfs.enable = true;
}
