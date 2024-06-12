{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.jellyfin;
in {
  options.nozomi.apps.jellyfin = with types; {
    enable =
      mkBoolOpt false "Whether to enable jellyfin.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ jellyfin ];
  };
}
