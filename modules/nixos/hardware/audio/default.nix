{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.hardware.audio;
in {
  options.nozomi.hardware.audio = with types; {
    enable = mkBoolOpt false "Whether or not to enable audio support.";
    alsa-monitor = mkOpt attrs {} "Alsa configuration.";
    nodes =
      mkOpt (listOf attrs) []
      "Audio nodes to pass to Pipewire as `context.objects`.";
    modules =
      mkOpt (listOf attrs) []
      "Audio modules to pass to Pipewire as `context.modules`.";
    extra-packages =
      mkOpt (listOf package) [
      ] "Additional packages to install.";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
      # wireplumber.enable = true;
    };

    hardware.pulseaudio.enable = mkForce false;

    environment.systemPackages = with pkgs;
      [
        pulsemixer
        pavucontrol
      ]
      ++ cfg.extra-packages;

    nozomi.user.extraGroups = ["audio"];
  };
}
