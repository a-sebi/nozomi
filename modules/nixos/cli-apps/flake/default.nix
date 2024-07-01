{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.cli-apps.flake;
in {
  options.nozomi.cli-apps.flake = with types; {
    enable =
      mkBoolOpt false "Whether to enable flake.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [snowfallorg.flake];
  };
}
