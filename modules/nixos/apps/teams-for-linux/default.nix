{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.teams-for-linux;
in {
  options.nozomi.apps.teams-for-linux = with types; {
    enable =
      mkBoolOpt false "Whether to enable teams-for-linux.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [teams-for-linux];
  };
}
