{
  description = "Home Manager configuration of keshav";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    stylix.url = "github:nix-community/stylix/release-25.05";

    ignis = {
      url = "github:ignis-sh/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{self, ...}:
    let
      system = "x86_64-linux";
      # pkgs = inputs.nixpkgs.legacyPackages.${system};
      pkgs = import inputs.nixpkgs {system = system; config.allowUnfree = true;};
      systemSettings = {
        hostname = "knix";
        timezone = "Asia/Kolkata";
        defaultLocale = "en_US.UTF-8";
        autologinUser = null;  # null if don't want autologin
      };
      userSettings = {
        name = "Keshav";
        username = "keshav";
        useremail = "keshav@knix.home";
      };
    in {
      nixosConfigurations = {
        ${systemSettings.hostname} = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [./configuration.nix];
          specialArgs = {
            inherit systemSettings userSettings inputs;
          };
        };
      };
      homeConfigurations.${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          inputs.stylix.homeModules.stylix
        ];
        extraSpecialArgs = {
          inherit self userSettings inputs system;
        };
      };
    };
}
