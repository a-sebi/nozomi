{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.desktop.hyprland;
  substitutedConfig = pkgs.substituteAll {
    ## TODO Note that this seems to be the Hyprland config path, to be tested, this may need to be omitted
    src = ./config;
  };
in {
  options.nozomi.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable Hyprland.";
    wallpaper = mkOpt (nullOr package) null "The wallpaper to display.";
    extraConfig =
      mkOpt str "" "Additional configuration for the Sway config file.";
  };

  config = mkIf cfg.enable {
    # Desktop additions
    nozomi.desktop.addons = {
      wofi = enabled;
      waybar = enabled;
      swaylock = enabled;
      swayidle = enabled;
      wlogout = enabled;
    };

    programs.hyprland = {
      enable = true;
      extraPackages = with pkgs; [
        wl-clipboard
        playerctl
        brightnessctl
        grim
        libnotify
        networkmanagerapplet
      ];
      xwayland.enable = true;
      #nvidiaPatches = true; # Only use if nvidia card is used. This may need to be a system-specific config line
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM="wayland;xcb"
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export QT_AUTO_SCREEN_SCALE_FACTOR=1
        export QT_QPA_PLATFORMTHEME=qt5ct
        export MOZ_ENABLE_WAYLAND=1
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP= Hyprland
        export XDG_CURRENT_DESKTOP= Hyprland
      '';
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # This variable fixes electron apps in wayland

  # environment.systemPackages = with pkgs;
  #  [
  #    (pkgs.writeTextFile {
  #      name = "startsway";
  #      destination = "/bin/startsway";
  #      executable = true;
  #      text = ''
  #        #! ${pkgs.bash}/bin/bash

  #        # Import environment variables from the login manager
  #        systemctl --user import-environment

  #        # Start Sway
  #        exec systemctl --user start sway.service
  #      '';
  #    })
  #  ];
}
