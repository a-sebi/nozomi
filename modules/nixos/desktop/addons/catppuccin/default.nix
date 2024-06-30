{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.addons.catppuccin;
in {
  options.nozomi.desktop.addons.catppuccin = with types; {
    enable =
      mkBoolOpt false "Whether to enable catppuccin.";
  };

  config = mkIf cfg.enable {
    catppuccin.enable = true;
    catppuccin.flavor = "frappe";
    catppuccin.accent = "red";
    services.displayManager.sddm.catppuccin.enable = true;
    services.displayManager.sddm.catppuccin.font = "Montserrat";
    boot.loader.grub.catppuccin.enable = true;
  };
}
