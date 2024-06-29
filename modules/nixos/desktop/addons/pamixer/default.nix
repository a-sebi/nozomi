{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.pamixer;
in {
  options.nozomi.desktop.addons.pamixer = with types; {
    enable =
      mkBoolOpt false "Whether to enable pamixer.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ pamixer ];
  };
}
