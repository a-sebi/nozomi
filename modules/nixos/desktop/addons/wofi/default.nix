{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.wofi;
in {
  options.nozomi.desktop.addons.wofi = with types; {
    enable =
      mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [wofi wofi-emoji];

    # config -> .config/wofi/config
    # css -> .config/wofi/style.css
    # colors -> $XDG_CACHE_HOME/wal/colors

    # Enable the below when config is added
    # nozomi.home.configFile."wofi/config".source = ./config;
    # nozomi.home.configFile."wofi/style.css".source = ./style.css;
  };
}
