{ options, config, lib, pkgs, ... }:

with lib;
with lib.nozomi;
let cfg = config.nozomi.tools.dev;
in
{
  options.nozomi.tools.dev = with types; {
    enable = mkBoolOpt false "Whether or not to enable development tools.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alejandra
      tldr
    ];
  };
}
