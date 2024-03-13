{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.calibre;
in {
  options.nozomi.apps.calibre = with types; {
    enable =
      mkBoolOpt false "Whether to enable calibre.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [calibre];
  };
}
