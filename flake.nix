{
  description = "nixos btw";
  inputs = {
	nixpkgs = {
	url = "nixpkgs/nixos-unstable";
	};
	home-manager = {
		url = "github:nix-community/home-manager";
		inputs = {
			nixpkgs = {
				follows = "nixpkgs";
			};
		};
	};
	nixcord = {
		url = "github:FlameFlag/nixcord";
	};
  };
  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
	nixosConfigurations = {
		taichi = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						extraSpecialArgs = {
							inputs = { nixcord = inputs.nixcord; };
						};
						users = {
							tahmid = {
								imports = [ 
									./home.nix
									inputs.nixcord.homeModules.nixcord
								];
							};
						};
						backupFileExtension = "backup";
					};
					}
				];
			};
		};
	};
}

