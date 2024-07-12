{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.tools.gpg;
in {
  options.nozomi.tools.gpg = with types; {
    enable = mkBoolOpt false "Whether or not to enable gpg.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnupg
    ];
  };
}
