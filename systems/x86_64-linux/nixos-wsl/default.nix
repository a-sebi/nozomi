{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,
  # Additional metadata is provided by Snowfall Lib.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.
  # All other arguments come from the system system.
  config,
  ...
}:
with lib;
with lib.nozomi; {
  #{

  # Your configuration.
  imports = [
  ];
  wsl.enable = true;
  wsl.defaultUser = "asebi";
  wsl.nativeSystemd = true;
  wsl.wslConf.network.hostname = "nixos-wsl";

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
    # Settings for nix-direnv to persist garbage collection
    keep-outputs = true;
    keep-derivations = true;
  };

  time.timeZone = "Australia/Melbourne";
  #i18n.defaultLocale = "en_AU.UTF-8";

  #users.users = {
  #  asebi = {
  #    isNormalUser = true;
  #    extraGroups = [ "wheel" ];
  #    #shell = pkgs.zsh;
  #  };
  #};

  nozomi = {
    sets = {
      desktop = disabled;
    };

    apps = {
      vlc = disabled;
    };

    cli-apps = {
      #neovim = enabled;
      eza = enabled;
    };

    tools = {
      git = enabled;
      tree = enabled;
      dev = enabled;
    };

    services = {
      openssh = enabled;
    };
  };

  nix = {
    # Garbage collection
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 30d";
  };

  environment.systemPackages = with pkgs; [
    wget
    vim
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
