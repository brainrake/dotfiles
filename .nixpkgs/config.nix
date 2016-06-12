{
  allowUnfree = true;
  chromium = {
    enablePepperFlash = true;
    enablePepperPDF = true;
  };


  packageOverrides = pkgs_: with pkgs_; {
    my_ = with pkgs; buildEnv {
      name = "my_";
      paths = [
        i3 i3status i3lock dmenu compton xorg.xbacklight volumeicon xorg.xev hsetroot
        arandr glxinfo
        zsh rxvt_unicode bc
        git
        sublime3 textadept atom
        mc htop psmisc pcmanfm
        feh geeqie scrot
        nox
        chromium firefox
        transmission_gtk
        mpv
        # nodejs
      ];
    };
  };
}
