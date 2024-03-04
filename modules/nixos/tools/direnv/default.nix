{ options, config, lib, pkgs, ... }:

with lib;
with lib.nozomi;
let cfg = config.nozomi.tools.direnv;
in
{
  options.nozomi.tools.direnv = with types; {
    enable = mkBoolOpt false "Whether or not to enable direnv.";
  };

  config = mkIf cfg.enable {
    nozomi.home.extraOptions = {
      programs.direnv = {
        enable = true;
        nix-direnv = enabled;
      };
    };
  };
}
