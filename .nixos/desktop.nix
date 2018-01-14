{ config, pkgs, ... }:
{
  imports = [ ./common.nix ./graphical.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lada";
}
