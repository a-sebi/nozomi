{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.libnotify;
in {
  options.nozomi.desktop.addons.libnotify = with types; {
    enable =
      mkBoolOpt false "Whether to enable libnotify.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [libnotify];
  };
}
