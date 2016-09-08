{
  allowUnfree = true;
  chromium.enablePepperFlash = true;
  chromium.enablePepperPDF = true;
  # chromium.jre = true;
  # firefox.jre = true;
  packageOverrides = pkgs_: with pkgs_; {
    my_ = with pkgs; buildEnv {
      name = "my_";
      paths = [
        i3 i3status i3lock dmenu
        xorg.xbacklight xorg.xev xorg.xkbcomp xorg.xmodmap hsetroot glxinfo volumeicon xorg.xev compton
        rxvt_unicode feh geeqie scrot arandr lxappearance mpv pcmanfm gcolor2
        chromium firefox thunderbird
        # transmission-gtk seahorse
        sublime3 textadept mixxx # atom
        git gcc racket
        haskellPackages.purescript  # haskellPackages.idris
        nodejs nodePackages.coffee-script
        iputils bind nmap mtr # terraform  # urbit
        nox bc mc htop psmisc file graphviz imagemagick pciutils gnupg
      ];
    };
  };
}
