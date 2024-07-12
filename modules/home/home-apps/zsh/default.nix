{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) types mkEnableOption mkIf;
  inherit (lib.nozomi) mkOpt;

  cfg = config.nozomi.home-apps.zsh;

  zsh-directory = ./p10k-config;
in {
  options.nozomi.home-apps.zsh = {
    enable = mkEnableOption "ZSH";
    #zsh = mkOpt (types.nullOr types.str) zsh-directory "The user's zsh config directory.";
  };

  config = mkIf cfg.enable {
    programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        initExtra = ''
          # Fix an issue with tmux.
          export KEYTIMEOUT=1

          # Add atuin.
          eval "$(atuin init zsh)"

          # Doom Emacs bin path
          path+=('/home/asebi/.config/emacs/bin')
        '';

        shellAliases = {
          sl = "eza";
          ls = "eza";
          l = "eza -l";
          la = "eza -la";
          ip = "ip --color=auto";
          vim = "nvim";
          grep = "grep --color=auto";
        };

        oh-my-zsh = {
          enable = true;

          plugins = [
            "git"
            "history"
            "command-not-found"
            "sudo"
          ];
        };

        plugins = [
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.4.0";
              sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
            };
          }
          {
            name = "powerlevel10k";
            file = "powerlevel10k.zsh-theme";
            src = pkgs.fetchFromGitHub {
              owner = "romkatv";
              repo = "powerlevel10k";
              rev = "35833ea15f14b71dbcebc7e54c104d8d56ca5268";
              sha256 = "ES5vJXHjAKw/VHjWs8Au/3R+/aotSbY7PWnWAMzCR8E=";
            };
          }
          {
            name = "powerlevel10k-config";
            src = zsh-directory;
            file = "p10k.zsh";
          }
        ];
      };

      starship = {
        enable = true;
        settings = {
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[✗](bold red) ";
            vicmd_symbol = "[](bold blue) ";
          };
        };
      };
    };
  };
}
