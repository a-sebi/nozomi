{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.floorp;
in {
  options.nozomi.apps.floorp = with types; {
    enable = mkBoolOpt false "Whether or not to enable Floorp.";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [floorp];};
}
