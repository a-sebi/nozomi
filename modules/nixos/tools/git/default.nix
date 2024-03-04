{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.tools.git;
  #user = config.plusultra.user;
in {
  options.nozomi.tools.git = with types; {
    enable = mkBoolOpt false "Enable or disable git";
    #userName = mkOpt types.str user.fullName "The name to configure git with.";
    #userEmail = mkOpt types.str user.email "The email to configure git with.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      #git-remote-gcrypt

      gh # GitHub cli

      lazygit
      #commitizen
    ];

    environment.shellAliases = {
      # Git aliases
      ga = "git add .";
      gc = "git commit -m ";
      gp = "git push -u origin";

      g = "lazygit";
    };

    #nozomi.home.extraOptions = {
    #  programs.git = {
    #    enable = true;
    #    inherit (cfg) userName userEmail;
    #    extraConfig = {
    #      init = { defaultBranch = "main"; };
    #      pull = { rebase = true; };
    #      push = { autoSetupRemote = true; };
    #      core = { whitespace = "trailing-space,space-before-tab"; };
    #    };
    #  };
    #};

    nozomi.home.configFile."git/config".text = import ./config.nix {sshKeyPath = "/home/${config.nozomi.user.name}/.ssh/id_ed25519.pub"; name = "Afdal Sebi"; email = "ssiabe@protonmail.com";};
    nozomi.home.configFile."lazygit/config.yml".source = ./lazygitConfig.yml;
  };
}
