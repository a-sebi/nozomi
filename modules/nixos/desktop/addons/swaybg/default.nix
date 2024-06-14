{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.swaybg;
in {
  options.nozomi.desktop.addons.swaybg = with types; {
    enable =
      mkBoolOpt false "Whether to enable swaybg in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [swaybg];
  };
}
