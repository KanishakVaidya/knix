{
  description = "Home Manager configuration of keshav";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    stylix.url = "github:danth/stylix";
  };

  outputs = inputs@{self, ...}:
    let
      system = "x86_64-linux";
      # pkgs = inputs.nixpkgs.legacyPackages.${system};
      pkgs = import inputs.nixpkgs {system = "x86_64-linux"; config.allowUnfree = true;};
      systemSettings = {
        hostname = "knix";
        timezone = "Asia/Kolkata";
        defaultLocale = "en_US.UTF-8";
        autologinUser = null;  # "username" if want autologin
      };
      userSettings = {
        name = "knix";
        username = "knix";
        useremail = "knix@knix.home";
      };
    in {
      nixosConfigurations = {
        knix = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [./configuration.nix];
          specialArgs = {
            inherit systemSettings userSettings;
          };
        };
      };
      homeConfigurations.keshav = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          inputs.stylix.homeManagerModules.stylix
        ];
        extraSpecialArgs = {
          inherit self userSettings inputs system;
        };
      };
    };
}
