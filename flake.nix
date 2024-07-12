{
  description = "Nozomi - NixOS Config";

  inputs = {
    # NixPkgs Unstable (nixos-unstable)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Snowfall Lib
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Snowfall Flake
    flake.url = "github:snowfallorg/flake";
    flake.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS Generators
    # nixos-generators.url = "github:nix-community/nixos-generators";
    # nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS WSL
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    # Lix
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "nozomi";
          title = "nozomi";
        };

        namespace = "nozomi";
      };
    };
  in
    lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
      };

      overlays = with inputs; [
      ];

      systems.modules.nixos = with inputs; [
        # home-manager.nixosModules.home-manager
        catppuccin.nixosModules.catppuccin
        lix-module.nixosModules.default
      ];

      systems.hosts.nixos-wsl.modules = with inputs; [
        nixos-wsl.nixosModules.wsl
      ];

      homes.modules = with inputs; [
        catppuccin.homeManagerModules.catppuccin
      ];

      #templates = import ./templates {};
    };
}
