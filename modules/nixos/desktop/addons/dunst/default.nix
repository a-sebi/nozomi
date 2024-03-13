{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.dunst;
in {
  options.nozomi.desktop.addons.dunst = with types; {
    enable =
      mkBoolOpt false "Whether to enable dunst.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [dunst];
  };
}
