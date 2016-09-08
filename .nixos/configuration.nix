{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # nix.useSandbox = true;

  # Use the systemd-boot EFI boot loader.
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

  fileSystems."/home/ssdd/.nixos".device = "/etc/nixos";
  fileSystems."/home/ssdd/.nixos".options = [ "defaults" "bind" ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;

  networking.hostName = "eki";
  networking.networkmanager.enable = true;
  
  networking.firewall.enable = false;
  
  hardware = {
    opengl = {
      driSupport32Bit = true;
      extraPackages = [ pkgs.vaapiIntel ] ;
    };
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };
  security.rtkit.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  time.timeZone = "Europe/Budapest";

  # environment.systemPackages = with pkgs; [
  #   wget
  # ];

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.enable = true;
    publish.domain = true;
    publish.addresses = true;
  };

  services.openssh.enable = true;
  services.printing.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    windowManager.i3.enable = true;
    displayManager.slim = {
      enable = true;
      theme = pkgs.fetchurl {
        url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
        sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
      };
    };
    videoDrivers = [ "intel" ];
    enableCtrlAltBackspace = true;
    synaptics = {
      enable = true;
      twoFingerScroll = true;
      vertEdgeScroll = false;
      palmDetect = true;
      additionalOptions = ''
        Option "VertScrollDelta" "-27"
        Option "HorizScrollDelta" "-27"
        Option "AccelFactor" "0.1"
      '';
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      terminus_font ubuntu_font_family
    ];
  };

  programs.zsh.enable = true;

  users.extraUsers.ssdd = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "vboxusers" "docker"];
    shell = "/run/current-system/sw/bin/zsh";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";
}
