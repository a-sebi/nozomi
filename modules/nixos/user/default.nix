{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nozomi; let
  cfg = config.nozomi.user;
  defaultIconFileName = "profile.png";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";

    dontUnpack = true;

    installPhase = ''
      cp $src $out
    '';

    passthru = {fileName = defaultIconFileName;};
  };
  #propagatedIcon =
  #  pkgs.runCommandNoCC "propagated-icon"
  #  {passthru = {fileName = cfg.icon.fileName;};}
  #  ''
  #    local target="$out/share/nozomi-icons/user/${cfg.name}"
  #    mkdir -p "$target"

  #    cp ${cfg.icon} "$target/${cfg.icon.fileName}"
  #  '';
in {
  options.nozomi.user = with types; {
    name = mkOpt str "asebi" "The name to use for the user account.";
    fullName = mkOpt str "Afdal Sebi" "The full name of the user.";
    email = mkOpt str "afdalsebi@pm.me" "The email of the user.";
    initialPassword =
      mkOpt str "password"
      "The initial password to use when the user is first created.";
    icon =
      mkOpt (nullOr package) defaultIcon
      "The profile picture to use for the user.";
    prompt-init = mkBoolOpt true "Whether or not to show an initial message when opening a new shell.";
    extraGroups = mkOpt (listOf str) [] "Groups for the user to be assigned.";
    extraOptions =
      mkOpt attrs {}
      (mdDoc "Extra options passed to `users.users.<name>`.");
  };

  config = {
    environment.systemPackages = with pkgs; [
      fortune
      #propagatedIcon
    ];

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      histFile = "$XDG_CACHE_HOME/zsh.history";
    };

    nozomi.home = {
      file = {
        "Desktop/.keep".text = "";
        "Documents/.keep".text = "";
        "Downloads/.keep".text = "";
        "Music/.keep".text = "";
        "Pictures/.keep".text = "";
        "Videos/.keep".text = "";
        #"Work/.keep".text = "";
        #".face".source = cfg.icon;
        #"Pictures/${
          #cfg.icon.fileName or (builtins.baseNameOf cfg.icon)
        #}".source =
          #cfg.icon;
      };

      extraOptions = {
        home.shellAliases = {
          lc = "${pkgs.colorls}/bin/colorls --sd";
          lcg = "lc --gs";
          lcl = "lc -1";
          lclg = "lc -1 --gs";
          lcu = "${pkgs.colorls}/bin/colorls -U";
          lclu = "${pkgs.colorls}/bin/colorls -U -1";
        };

        #programs = {

        #  zsh = {
        #    enable = true;
        #    enableCompletion = true;
        #    enableAutosuggestions = true;
        #    syntaxHighlighting.enable = true;

        #    initExtra =
        #      ''
        #        # Fix an issue with tmux.
        #        export KEYTIMEOUT=1

        #        # Use vim bindings.
        #        set -o vi
        #      '';

        #    shellAliases = {
        #    };

        #    plugins = [
        #      {
        #        name = "zsh-nix-shell";
        #        file = "nix-shell.plugin.zsh";
        #        src = pkgs.fetchFromGitHub {
        #          owner = "chisui";
        #          repo = "zsh-nix-shell";
        #          rev = "v0.4.0";
        #          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        #        };
        #      }
        #    ];
        #  };
        #};
      };
    };

    users.users.${cfg.name} =
      {
        isNormalUser = true;

        inherit (cfg) name initialPassword;

        home = "/home/${cfg.name}";
        group = "users";

        shell = pkgs.zsh;

        # Arbitrary user ID to use for the user. Since I only
        # have a single user on my machines this won't ever collide.
        # However, if you add multiple users you'll need to change this
        # so each user has their own unique uid (or leave it out for the
        # system to select).
        #uid = 1000;

        #extraGroups = ["steamcmd"] ++ cfg.extraGroups;
      }
      // cfg.extraOptions;
  };
}
