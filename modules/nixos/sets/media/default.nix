{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.sets.media;
in {
  options.nozomi.sets.media = with types; {
    enable = mkBoolOpt false "Whether or not to enable media configuration.";
  };

  config = mkIf cfg.enable {
    nozomi = {
      apps = {
        calibre = enabled;
        jellyfin = enabled;
      };
    };
  };
}
