{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.emacs;
in {
  options.nozomi.apps.emacs = with types; {
    enable = mkBoolOpt false "Whether or not to enable Emacs.";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [
    ((emacsPackagesFor emacs29).emacsWithPackages (epkgs: [
    epkgs.vterm
    epkgs.pdf-tools
    ]))
  ];};
}
