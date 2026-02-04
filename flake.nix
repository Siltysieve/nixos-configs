{
	description = "NixOS from Scratch";
	
  inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";
		gestures.url = "github:riley-martin/gestures";
		
    home-manager = { 
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

  	caelestia-shell = {
    url = "github:caelestia-dots/shell";
    inputs.nixpkgs.follows = "nixpkgs";
  	};
};

	outputs = { self, nixpkgs, home-manager, caelestia-shell, ... }: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{ 
				   home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.blue = import ./home.nix;
						backupFileExtension = "backup";
						sharedModules = [ caelestia-shell.homeManagerModules.default ];
						};
			    }
				];
			};
		};

}
