{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.tools.tree;
in {
  options.nozomi.tools.tree = with types; {
    enable = mkBoolOpt false "Enable or disable tree";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tree
    ];
  };
}
