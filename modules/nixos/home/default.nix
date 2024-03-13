{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.home;
in {
  # imports = with inputs; [
  #   home-manager.nixosModules.home-manager
  # ];

  options.nozomi.home = with types; {
    file =
      mkOpt attrs {}
      (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile =
      mkOpt attrs {}
      (mdDoc "A set of files to be managed by home-manager's `xdg.configFile`.");
    extraOptions = mkOpt attrs {} "Options to pass directly to home-manager.";
  };

  config = {
    nozomi.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.nozomi.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.nozomi.home.configFile;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.${config.nozomi.user.name} =
        mkAliasDefinitions options.nozomi.home.extraOptions;
    };
  };
}
