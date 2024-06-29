{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.thunderbird;
in {
  options.nozomi.apps.thunderbird = with types; {
    enable = mkBoolOpt false "Whether or not to enable thunderbird.";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [thunderbird];};
}
