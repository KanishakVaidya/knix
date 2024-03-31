{
  description = "Home Manager configuration of keshav";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      systemSettings = {
        hostname = "knix";
      };
      userSettings = {
        username = "keshav";
        useremail = "keshav@knix.home";
      };
    in {
      nixosConfigurations = {
        knix = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
          specialArgs = {
            inherit systemSettings;
          };
        };
      };
      homeConfigurations.keshav = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./home.nix];
        extraSpecialArgs = {
          inherit userSettings;
        };
      };
    };
}
