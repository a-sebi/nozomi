{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.wl-clipboard;
in {
  options.nozomi.desktop.addons.wl-clipboard = with types; {
    enable =
      mkBoolOpt false "Whether to enable wl-clipboard.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [wl-clipboard];
  };
}
