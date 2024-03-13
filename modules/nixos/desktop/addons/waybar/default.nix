{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.waybar;
in {
  options.nozomi.desktop.addons.waybar = with types; {
    enable =
      mkBoolOpt false "Whether to enable Waybar in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [waybar];

    # nozomi.home.configFile."waybar/config".source = ./config;
    # nozomi.home.configFile."waybar/style.css".source = ./style.css;
  };
}
