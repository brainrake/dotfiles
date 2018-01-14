{ config, pkgs, lib, ... }:
{
  imports = [ ./common.nix ];

  networking.hostName = "calculon";

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
}
