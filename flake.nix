{
  description = "i cant name things";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      dell-latitude = lib.nixosSystem {
        inherit system;
	modules = [ ./configuration.nix ];
      };
    };
    homeConfigurations.mtgmonkey = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
      ];
    };
  };
}
