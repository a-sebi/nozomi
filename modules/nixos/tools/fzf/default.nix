{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.tools.fzf;
in {
  options.nozomi.tools.fzf = with types; {
    enable = mkBoolOpt false "Enable or disable fzf";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fzf
    ];
  };
}
