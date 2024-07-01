{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.archetypes.workstation;
in {
  options.nozomi.archetypes.workstation = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    nozomi = {
      sets = {
        common = enabled;
        desktop = enabled;
        media = enabled;
      };

      tools = {
      };
    };
  };
}
