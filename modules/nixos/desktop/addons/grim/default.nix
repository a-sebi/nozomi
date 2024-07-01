{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.grim;
in {
  options.nozomi.desktop.addons.grim = with types; {
    enable =
      mkBoolOpt false "Whether to enable grim.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [grim];
  };
}
