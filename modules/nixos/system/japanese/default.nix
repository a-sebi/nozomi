{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.system.japanese;
in {
  options.nozomi.system.japanese = with types; {
    enable = mkBoolOpt false "Whether or not to enable Japanese.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdjapanese.
      GLFW_IM_MODULE = "fcitx";
    };

    fonts.packages = with pkgs; [
      ipafont
    ];

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = [
        pkgs.fcitx5-mozc
        pkgs.fcitx5-gtk
        pkgs.fcitx5-configtool
      ];
    };
  };
}
