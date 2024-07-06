{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.nozomi.home-apps.emacs;
in {
  options.nozomi.home-apps.emacs = {
    enable = mkEnableOption "Emacs";
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        # Doom Emacs dependencies
        git
        emacs
        ripgrep
        gnutls
        emacs-all-the-icons-fonts
        libvterm
        gnutls
        coreutils
        fd
        clang
      ];

      # sessionPath = ["${config.xdg.configHome}/.emacs.d/bin"];
      sessionVariables = {
        #DOOMDIR = ./doom;
        #DOOMDIR = "${config.xdg.configHome}/doom-config";
        DOOMDIR = "${config.xdg.configHome}/.doom";
        DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
      };
    };

    programs.emacs = {
      # enable = true;
      extraPackages = epkgs: [
        epkgs.vterm
      ];
    };
    services.emacs = {
      enable = true;
    };
  };
}
