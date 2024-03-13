{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.anki;
in {
  options.nozomi.apps.anki = with types; {
    enable =
      mkBoolOpt false "Whether to enable anki in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [anki];
  };
}
