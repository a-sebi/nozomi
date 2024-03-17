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
      wl-clipboard = enabled;
      playerctl = enabled;
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      #enablenvidiaPatches = true; # Only use if nvidia card is used. This may need to be a system-specific config line
    };
    # Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    environment = {
      sessionVariables = {
        NIXOS_OZONE_WL = "1"; # This variable fixes electron apps in wayland
        SDL_VIDEODRIVER = "wayland";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_QPA_PLATFORMTHEME = "qt5ct";
        MOZ_ENABLE_WAYLAND = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
        XDG_CURRENT_DESKTOP = "Hyprland";
      };
    };

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
  };
}
