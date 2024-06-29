{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.sets.work;
in {
  options.nozomi.sets.work = with types; {
    enable = mkBoolOpt false "Whether or not to enable work configuration.";
  };

  config = mkIf cfg.enable {
    nozomi = {
      apps = {
        teams-for-linux = enabled;
      };
    };
  };
}
