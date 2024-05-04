{
  description = "Home Manager configuration of keshav";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs = inputs@{self, ...}:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      systemSettings = {
        hostname = "knix";
      };
      userSettings = {
        username = "keshav";
        useremail = "keshav@knix.home";
      };
    in {
      nixosConfigurations = {
        knix = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
          specialArgs = {
            inherit systemSettings;
          };
        };
      };
      homeConfigurations.keshav = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./home.nix];
        extraSpecialArgs = {
          inherit self userSettings inputs system;
        };
      };
    };
}
