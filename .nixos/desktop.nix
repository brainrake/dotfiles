{ config, pkgs, ... }:
{
  imports = [ ./common.nix ./graphical.nix ];

  # TODO:
  #   - bluetooth audio
  #   - opensnitch
  #   - little flocker
}
