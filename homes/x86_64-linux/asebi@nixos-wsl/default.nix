{ lib, pkgs, config, osConfig ? { }, format ? "unknown", ... }:

with lib.nozomi;
{
  nozomi = {
    user = {
      enable = true;
      name = config.snowfallorg.user.name;
    };

    home-apps = {
      emacs = enabled;
      neovim = enabled;
      home-manager = enabled;
      zsh = enabled;
    };
  };

  home.stateVersion = "24.05";
}
