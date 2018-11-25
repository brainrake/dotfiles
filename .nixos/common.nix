{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.earlyVconsoleSetup = true;
  # boot.kernelParams = [ "systemd.legacy_systemd_cgroup_controller=yes" ]; # pray for docker
  boot.supportedFilesystems = [ "ext" "exfat" "vfat" "ntfs" "xfs" ];

  nix.useSandbox = true;

  nixpkgs.config.allowUnfree = true;

  fileSystems."/home/ssdd/.nixos" = {
    device = "/etc/nixos";
    options = [ "defaults" "bind" ];
  };

  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;
 
  networking.firewall.enable = false;

  security.rtkit.enable = true;

  powerManagement = {
    enable = true;
    # cpuFreqGovernor = "powersave";
  };

  time.timeZone = "Europe/Budapest";

  services.avahi = {
    enable = true;
    nssmdns = true;
    ipv6 = true;
    publish.enable = true;
    publish.domain = true;
    publish.workstation = true;
    publish.hinfo = true;
    publish.addresses = true;
    publish.userServices = true;
  };

  services.openssh.enable = true;
  services.openssh.forwardX11 = true;

  programs.zsh.enable = true;

  users.extraUsers.ssdd = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "vboxusers" "docker" "dialout" "audio" "video" "storage" "adbusers" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";
}
