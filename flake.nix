{ 
	description = "Configuración de NixOS + Home Manager"; 
	inputs = { 
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = { 
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		}; 

		# Antigravity repo
		antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	}; 

	outputs = { nixpkgs, home-manager, ... }@inputs: {
		# Configuración del sistema NixOS (requiere sudo) 
		nixosConfigurations.Dante-NixOS = nixpkgs.lib.nixosSystem { 
			system = "x86_64-linux";

      specialArgs = { inherit inputs; };

			modules = [
				./hardware-configuration.nix 
				./configuration.nix
				home-manager.nixosModules.home-manager # Módulo de home-manager en la configuración de NixOS

				{
          environment.systemPackages = [
            inputs.antigravity-nix.packages.x86_64-linux.default
          ];                                                                   ### <---
          # Aseguramos que permites software propietario (Antigravity lo es)
          nixpkgs.config.allowUnfree = true;
        }
				{
				# Configuración de Home Manager directamente aquí dentro de NixOS
					home-manager.users.ponnshe = {
					# Incluye la configuración del usuario desde home/default.nix
						imports = [ ./home/default.nix ];
					};
				} 
			];
		};
	};
}
