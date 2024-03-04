{ options, config, lib, pkgs, ... }:

with lib;
with lib.nozomi;
let
  cfg = config.nozomi.desktop.hyprland;
  term = config.nozomi.desktop.addons.term;
  substitutedConfig = pkgs.substituteAll {
    src = ./config;
    term = term.pkg.pname or term.pkg.name;
  };
in
{
  options.nozomi.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable Hyprland.";
    wallpaper = mkOpt (nullOr package) null "The wallpaper to display.";
    extraConfig =
      mkOpt str "" "Additional configuration for the Sway config file.";
  };

  #programs.hyprland = {
  #  enable = true;
  #  extraPackages = with pkgs; [
  #    wofi
  #    swaylock
  #    wl-clipboard
  #    playerctl
  #    brightnessctl
  #  ];
  #};
}

