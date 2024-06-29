{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.system.icons;
in {
  options.nozomi.system.icons = with types; {
    enable = mkBoolOpt false "Whether or not to manage icons.";
    icons = mkOpt (listOf package) [] "Custom icon packages to install.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [themechanger tela-icon-theme];

    # icons.packages = with pkgs;
    #   [
    #     tela-icon-theme
    #   ]
    #   ++ cfg.icons;

    nozomi.home.extraOptions = {
      gtk = {
        enable = true;

        iconTheme = {
          name = "tela";
          package = pkgs.tela-icon-theme;
        };
      };
    };

  };
}
