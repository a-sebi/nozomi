{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with inputs; let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.nozomi) enabled;

  cfg = config.nozomi.home-apps.catppuccin;
in {
  options.nozomi.home-apps.catppuccin = {
    enable = mkEnableOption "Catppuccin";
  };

  config = mkIf cfg.enable {
    # home-manager.users.${config.nozomi.user.name} = {
    #   imports = [
    #     catppuccin.homeManagerModules.catppuccin
    #   ];
    # };
    catppuccin = {
      enable = true;
      flavor = "frappe";
      pointerCursor.enable = true;
    };
    gtk.catppuccin.enable = true;
    gtk.catppuccin.flavor = "frappe";
    programs.bottom.catppuccin.enable = true;
    programs.neovim.catppuccin.enable = true;
    programs.kitty.catppuccin.enable = true;
  };
}
