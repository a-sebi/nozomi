{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.vorta;
in {
  options.nozomi.apps.vorta = with types; {
    enable = mkBoolOpt false "Whether or not to enable vorta.";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [vorta];};
}
