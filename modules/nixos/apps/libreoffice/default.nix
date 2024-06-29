{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.libreoffice;
in {
  options.nozomi.apps.libreoffice = with types; {
    enable = mkBoolOpt false "Whether or not to enable libreoffice.";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [libreoffice];};
}
