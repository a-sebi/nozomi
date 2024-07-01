{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.playerctl;
in {
  options.nozomi.desktop.addons.playerctl = with types; {
    enable =
      mkBoolOpt false "Whether to enable playerctl.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [playerctl];
  };
}
