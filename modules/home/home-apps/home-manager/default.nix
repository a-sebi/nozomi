{ lib, config, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.nozomi) enabled;

  cfg = config.nozomi.home-apps.home-manager;
in
{
  options.nozomi.home-apps.home-manager = {
    enable = mkEnableOption "home-manager";
  };

  config = mkIf cfg.enable {
    programs.home-manager = enabled;
  };
}
