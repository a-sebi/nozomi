{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.cli-apps.atuin;
in {
  options.nozomi.cli-apps.atuin = with types; {
    enable =
      mkBoolOpt false "Whether to enable atuin in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [atuin];
  };
}
