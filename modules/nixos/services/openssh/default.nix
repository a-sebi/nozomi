{
  options,
  config,
  pkgs,
  lib,
  host ? "",
  format ? "",
  inputs ? {},
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.services.openssh;

  #user = config.users.users.${config.nozomi.user.name};
  #user-id = builtins.toString user.uid;

  # TODO: This is a hold-over from an earlier Snowfall Lib version which used
  # the specialArg `name` to provide the host name.
  name = host;

in {
  options.nozomi.services.openssh = with types; {
    enable = mkBoolOpt false "Whether or not to configure OpenSSH support.";
    authorizedKeys =
      mkOpt (listOf str) [default-key] "The public keys to apply.";
    port = mkOpt port 2222 "The port to listen on (in addition to 22).";
    manage-other-hosts = mkOpt bool true "Whether or not to add other host configurations to SSH config.";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;

      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
      };

      extraConfig = ''
        StreamLocalBindUnlink yes
      '';

      ports = [
        22
        cfg.port
      ];
    };

    #nozomi.home.extraOptions = {
    #  programs.zsh.shellAliases =
    #    foldl
    #    (aliases: system:
    #      aliases
    #      // {
    #        "ssh-${system}" = "ssh ${system} -t tmux a";
    #      })
    #    {}
    #    (builtins.attrNames other-hosts);
    #};
  };
}
