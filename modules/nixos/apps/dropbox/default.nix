{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.dropbox;
in {
  options.nozomi.apps.dropbox = with types; {
    enable =
      mkBoolOpt false "Whether to enable dropbox.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [dropbox];
  };
}
