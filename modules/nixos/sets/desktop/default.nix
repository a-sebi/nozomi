{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.sets.desktop;
in {
  options.nozomi.sets.desktop = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    nozomi = {
      desktop = {
        hyprland = enabled;
      };

      apps = {
        firefox = enabled;
        vlc = enabled;
        gparted = enabled;
        calibre = enabled;
        jellyfin = enabled;
      };
    };
  };
}
