{
  allowUnfree = true;
  chromium.enablePepperFlash = true;
  chromium.enablePepperPDF = true;
  packageOverrides = pkgs: rec {
    my_ = pkgs.buildEnv {
      name = "my_";
      paths = [ my_dev ];
    };
    my_dev = pkgs.buildEnv {
      name = "my_dev";
      paths = [ my_desktop ] ++ (with pkgs; [
        gnome3.seahorse
        google-chrome firefox
        git gcc racket elmPackages.elm nix-repl direnv meld file graphviz imagemagick
        haskellPackages.purescript haskellPackages.idris
        nodejs nodePackages.coffee-script
        sublime3 textadept atom
        mixxx
        gimp
        terraform
        urbit
      ]);
    };
    my_desktop = pkgs.buildEnv {
      name = "my_desktop";
      paths = [ my_tools ] ++ (with pkgs; [
        i3 i3status i3lock dmenu
        chromium # thunderbird
        xorg.xbacklight xorg.xev xorg.xkbcomp xorg.xmodmap hsetroot glxinfo volumeicon xorg.xev compton kdeconnect
        rxvt_unicode feh geeqie scrot arandr lxappearance mpv pcmanfm gcolor2 evince paprefs pavucontrol
        transmission_gtk
        pidgin pidginotr pidginlatex purple-hangouts purple-plugin-pack toxprpl
      ]);
    };
    my_tools = pkgs.buildEnv {
      name = "my_tools";
      paths = with pkgs; [
        iputils bind nmap mtr iptraf wget gnupg mkpasswd
        nox bc mc htop psmisc pciutils lm_sensors
      ];
    };
  };
}
