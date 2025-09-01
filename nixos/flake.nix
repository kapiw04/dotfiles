{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    # Pin nixpkgs to the commit where gamescope=3.16.4
    nixpkgs-gamescope.url = "github:NixOS/nixpkgs/9e1f33d1c971ba85d7f51338bbfd7ceefb07e7c8";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    pkgsGamescope = import inputs.nixpkgs-gamescope {inherit system;};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          environment.systemPackages = [
            alejandra.packages.${system}.default
            pkgsGamescope.gamescope # <- gamescope 3.16.4
          ];
        }
        # Home Manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.kapi = import ./home.nix;
        }
      ];
    };
  };
}
