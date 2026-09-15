{
  description = "Home Manager configuration of keshav";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    stylix.url = "github:nix-community/stylix/release-26.05";

    ignis = {
      url = "github:KanishakVaidya/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
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

      devShells.${system}.python = import ./shells/python.nix {
        inherit pkgs;
      };
    };
}
