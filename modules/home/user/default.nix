{ lib, config, pkgs, osConfig ? { }, ... }:

let
  inherit (lib) types mkIf mkDefault mkMerge;
  inherit (lib.nozomi) mkOpt;

  cfg = config.nozomi.user;

  is-linux = pkgs.stdenv.isLinux;

  home-directory =
    if cfg.name == null then
      null
    else
      "/home/${cfg.name}";
in
{
  options.nozomi.user = {
    enable = mkOpt types.bool false "Whether to configure the user account.";
    name = mkOpt (types.nullOr types.str) config.snowfallorg.user.name "The user account.";

    fullName = mkOpt types.str "Afdal Sebi" "The full name of the user.";
    email = mkOpt types.str "afdalsebi@pm.me" "The email of the user.";

    home = mkOpt (types.nullOr types.str) home-directory "The user's home directory.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "nozomi.user.name must be set";
        }
        {
          assertion = cfg.home != null;
          message = "nozomi.user.home must be set";
        }
      ];

      home = {
        username = mkDefault cfg.name;
        homeDirectory = mkDefault cfg.home;
      };
    }
  ]);
}
