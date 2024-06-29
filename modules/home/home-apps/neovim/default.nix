{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.nozomi.home-apps.neovim;
in {
  options.nozomi.home-apps.neovim = {
    enable = mkEnableOption "Neovim";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
    };
    home = {
      packages = with pkgs; [
        less
        # neovim
      ];

      sessionVariables = {
        PAGER = "less";
        MANPAGER = "less";
        EDITOR = "nvim";
      };

      shellAliases = {
        vimdiff = "nvim -d";
      };
    };
  };
}
