{
  lib,
  pkgs,
  config,
  osConfig ? {},
  format ? "unknown",
  ...
}:
with lib.nozomi; {
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
      kitty = enabled;
    };
  };

  home.stateVersion = "24.05";
}
