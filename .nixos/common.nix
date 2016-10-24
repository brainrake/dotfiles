{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  nix.useSandbox = true;

  nixpkgs.config.allowUnfree = true;

  fileSystems."/home/ssdd/.nixos" = {
    device = "/etc/nixos";
    options = [ "defaults" "bind" ];
  };

  # virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;

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

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  time.timeZone = "Europe/Budapest";

  environment.systemPackages = with pkgs; [ gparted rfkill powertop ];

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

  services.tinc.networks.eket = {
    extraConfig = ''
      ConnectTo = eket
    '';
    chroot = false;
    debugLevel = 5;
    hosts.eket = ''
      Name = eket
      Address = eket.su
      Subnet = 192.168.2.0/24
      Ed25519PublicKey = MPet69vKLZO8YF52EnZYfk7r4dZnn9TW4tJr/u8tKFP
      PublicKey = MIICCgKCAgEA0pYJS4Spdpp1qJL5B0dKSqdtUFBR3AChEbGKZAClw29dLgdGWNRYaPFizJD4z3TjPzT46VGnQPKCPFfGdT9ItwXs+IXLxbeQIFXDl72wgJLD1dzsClZSlw7wINYwARU9auHJYuI7nh0ELOsoBq8przB1k2MONJMvMvVCh037h5HlP90BUwenvmJJVYq+a3jmkvGrkAzDKoBVk2v3Zl8bSqCeGzWDNvrds48zaTo6KFcuJiJnlVpLNROghI/FP4V6USqtmQRA2q1E/xxDxAN3FRqe9DkA2KKziqiihj+LoK4iS+Eq7Mjt8BCFf2Ax1+bC4IupkR/nOYGxaWpnpIiUaX+ozAxLXuKHtFxbkO0ez/dH/DiPUNnHTQzwYcuAm0YzYFnSvmpJmQqT6xZm7DiFbqa/y2I7xuOpqaJxC/lDed0Me4nYrVJzQIeYW0M5F/eee3dpnMKzBH2BJKs7nBYqQ42nfd5WMiRzWZVJMEOewCvywiBBEgwlhXWQjBZp4ZJnOD775qfcVSOO3REacPCAwTHlftxmgiu1nh/BQSPzf8luLM4l183kBSMw3KmbSri0H5WRXkLBt4D4HupwYQpjd5vnNbhcaLx+tPvto1oEjKx7vYP/lw5xwxNDWz7TBHT3wJ8vpomSKyuSwwb4a/UtzCIYI5OZ7/C/AGgz5nT+jHUCAwEAAQ==
    '';
  };

  services.openssh.enable = true;
  services.openssh.forwardX11 = true;
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
      # theme = pkgs.fetchurl {
      #   url = "https://github.com/Hinidu/nixos-solarized-slim-theme/archive/1.2.tar.gz";
      #   sha256 = "f8918f56e61d4b8f885a4dfbf1285aeac7d7e53a7458e32942a759fedfd95faf";
      # };
      defaultUser = "ssdd";
      extraConfig = ''
        welcome_msg
        session_msg
        intro_msg
        username_msg
        password_msg
      '';
    };
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
      corefonts terminus_font ubuntu_font_family
    ];
  };

  programs.zsh.enable = true;

  users.extraUsers.ssdd = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "vboxusers" "docker"];
    shell = "/run/current-system/sw/bin/zsh";
    hashedPassword = "$6$vHDzt8VRh2O$zAvDGW.itwlXb0OSapkkVQz3E9Ddn0/.0XljeNRB2vxSKNUxpy6GXrsBSyUucLyNq2FCW9KuvV9ViE5YFP8gs0";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";
}
