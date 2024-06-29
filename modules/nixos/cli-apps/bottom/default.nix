{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.cli-apps.bottom;
in {
  options.nozomi.cli-apps.bottom = with types; {
    enable =
      mkBoolOpt false "Whether to enable bottom.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [bottom];
  };
}
