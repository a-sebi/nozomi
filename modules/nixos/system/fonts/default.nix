{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.system.fonts;
in {
  options.nozomi.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [font-manager];

    fonts.packages = with pkgs;
      [
        montserrat
        hack-font
        meslo-lgs-nf
        fira-code
        fira-code-symbols
        fira-code-nerdfont
      ]
      ++ cfg.fonts;
  };
}
