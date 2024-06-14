{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.nozomi.home-apps.kitty;
in {
  options.nozomi.home-apps.kitty = {
    enable = mkEnableOption "Kitty";
  };

  config = mkIf cfg.enable {
    programs = {
      kitty = {
        enable = true;
        extraConfig = builtins.readFile ./kitty.conf;
      };
    };
  };
}
