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
        i3 i3status i3lock dmenu compton xbacklight
        zsh fish bc rxvt_unicode evilvte xfce.terminal
        sublime3 textadept
        mc htop psmisc
        feh geeqie scrot
        nox
        chromium firefox
        # nodejs
      ];
    };
  };
}
