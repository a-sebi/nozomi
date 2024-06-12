{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.slurp;
in {
  options.nozomi.desktop.addons.slurp = with types; {
    enable =
      mkBoolOpt false "Whether to enable slurp.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ slurp ];
  };
}
