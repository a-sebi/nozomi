{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.brightnessctl;
in {
  options.nozomi.desktop.addons.brightnessctl = with types; {
    enable =
      mkBoolOpt false "Whether to enable brightnessctl.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ brightnessctl ];
  };
}
