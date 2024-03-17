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
    environment.systemPackages = with pkgs; [ common ];
    nozomi = {
      cli-apps = {
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
    };
  };
}
