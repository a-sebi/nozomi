{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.networkmanagerapplet;
in {
  options.nozomi.desktop.addons.networkmanagerapplet = with types; {
    enable =
      mkBoolOpt false "Whether to enable networkmanagerapplet.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [networkmanagerapplet];
  };
}
