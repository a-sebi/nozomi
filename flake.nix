{
  description = "";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
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

      overlays = with inputs; [];
      

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
      ];

      systems.hosts.nixos-wsl.modules = with inputs; [
        nixos-wsl.nixosModules.wsl
      ];

      #templates = import ./templates {};
    };
}
