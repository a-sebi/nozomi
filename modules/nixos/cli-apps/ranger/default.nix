{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.cli-apps.ranger;
in {
  options.nozomi.cli-apps.ranger = with types; {
    enable =
      mkBoolOpt false "Whether to enable ranger.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ranger];
  };
}
