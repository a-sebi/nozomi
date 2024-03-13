{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.gparted;
in {
  options.nozomi.apps.gparted = with types; {
    enable = mkBoolOpt false "Whether or not to enable gparted.";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [gparted];};
}
