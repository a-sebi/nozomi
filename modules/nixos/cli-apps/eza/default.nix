inputs @ {
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.cli-apps.eza;
in {
  options.nozomi.cli-apps.eza = with types; {
    enable = mkBoolOpt false "Whether or not to enable eza.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      eza
    ];
  };
}
