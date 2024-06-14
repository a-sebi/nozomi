{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.sets.common;
in {
  options.nozomi.sets.common = with types; {
    enable =
      mkBoolOpt false "Whether to enable common configuration set.";
  };

  config = mkIf cfg.enable {
    nozomi = {
      cli-apps = {
        atuin = enabled;
        bottom = enabled;
        eza = enabled;
        flake = enabled;
      };

      tools = {
        git = enabled;
      };

      system = {
        fonts = enabled;
        locale = enabled;
        time = enabled;
      };

      hardware = {
        networking = enabled;
      };
    };
  };
}
