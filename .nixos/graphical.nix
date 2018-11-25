{congig, lib, pkgs, ...}: 
{
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.docker.enable = true;
  #virtualisation.libvirtd.enable = true;

  networking.networkmanager.enable = true;

  hardware = {
    opengl = rec {
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiIntel ]; # libvdpau-va-gl vaapiVdpau ] ;
      extraPackages32 = extraPackages;
    };
    bluetooth = {
      enable = true;
      extraConfig = ''
        [General]
        Enable=Source,Sink,Media,Socket
      '';
    };
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

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
      accelFactor = "0.1";
      additionalOptions = ''
        Option "VertScrollDelta" "-27"
        Option "HorizScrollDelta" "-27"
        Option "SingleTapTimeout" "30"
        Option "MaxTapTime" "100"
        Option "SingleTapTimeout" "100"
      '';
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [ corefonts terminus_font terminus_font_ttf ubuntu_font_family carlito hasklig mononoki fira fira-code fira-code-symbols fira-mono source-sans-pro source-serif-pro source-code-pro noto-fonts noto-fonts-cjk noto-fonts-emoji ];
  };

  environment.systemPackages = with pkgs; [
    gparted rfkill powertop
    i3 i3status i3lock dmenu rxvt_unicode
  ];

  # i18n.inputMethod.enabled = "fcitx";
}
