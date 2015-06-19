{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixbox";

  # Services to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable DBus
  services.dbus.enable    = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    ipv6 = true;
  };

  services.virtualboxHost.enable = true;
  services.virtualboxGuest.enable = true;
  boot.initrd.checkJournalingFS = false;

  # Default packages
  environment.systemPackages = with pkgs; [
    gcc
    git
    gnumake
    python
    zsh
    xlibs.xinit xlaunch xlibs.xauth xlibs.xrdb
  ];


  virtualisation.libvirtd.enable=true;

  services.xserver = {
    enable = true;
    enableTCP = false;
    #autorun = false;
    exportConfiguration = true;
    windowManager.i3.enable=true;
    layout = "us";
    desktopManager = {
      xterm.enable = false;
      xfce.enable = false;
    };
    displayManager.slim = {
      enable = true;
      defaultUser = "vagrant";
      extraConfig = 
      ''
        welcome_msg
        session_msg
        intro_msg
        username_msg
        password_msg
      '';
      theme = pkgs.fetchurl {
        url = "https://github.com/Hinidu/nixos-solarized-slim-theme/archive/1.2.tar.gz";
        sha256 = "f8918f56e61d4b8f885a4dfbf1285aeac7d7e53a7458e32942a759fedfd95faf";
      };
    };
    videoDriver = "virtualbox";
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      corefonts terminus_font ubuntu_font_family
    ];
  };

  programs.zsh.enable = true;

  security.setuidPrograms = [
    "xlaunch"
  ];

  # Creates a "vagrant" users with password-less sudo access
  users = {
    extraGroups = [ { name = "vagrant"; } { name = "vboxsf"; } ];
    extraUsers  = [ {
      description     = "Vagrant User";
      name            = "vagrant";
      group           = "vagrant";
      extraGroups     = [ "users" "vboxsf" "wheel" "vboxusers" "libvirtd"];
      password        = "vagrant";
      home            = "/home/vagrant";
      shell           = "/run/current-system/sw/bin/zsh";
      createHome      = true;
      useDefaultShell = true;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
      ];
    } ];
  };

  security.sudo.configFile =
    ''
      Defaults:root,%wheel env_keep+=LOCALE_ARCHIVE
      Defaults:root,%wheel env_keep+=NIX_PATH
      Defaults:root,%wheel env_keep+=TERMINFO_DIRS
      Defaults env_keep+=SSH_AUTH_SOCK
      Defaults lecture = never
      root   ALL=(ALL) SETENV: ALL
      %wheel ALL=(ALL) NOPASSWD: ALL, SETENV: ALL
    '';

    swapDevices = [ {
    	device = "/swap";
    	size = 4096;
    } ];
}
