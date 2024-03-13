{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.apps.discord;
in {
  options.nozomi.apps.discord = with types; {
    enable =
      mkBoolOpt false "Whether to enable discord.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [discord];
  };
}
