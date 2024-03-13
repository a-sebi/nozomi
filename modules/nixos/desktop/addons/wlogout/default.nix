{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.wlogout;
in {
  options.nozomi.desktop.addons.wlogout = with types; {
    enable =
      mkBoolOpt false "Whether to enable wlogout in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [wlogout];
  };
}
