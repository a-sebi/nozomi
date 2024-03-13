{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.swaylock;
in {
  options.nozomi.desktop.addons.swaylock = with types; {
    enable =
      mkBoolOpt false "Whether to enable swaylock in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [swaylock];
  };
}
