{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.signal-desktop;
in {
  options.nozomi.apps.signal-desktop = with types; {
    enable =
      mkBoolOpt false "Whether to enable signal-desktop.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [signal-desktop];
  };
}
