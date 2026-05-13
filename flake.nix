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

		luffy.url = "github:DemonKingSwarn/luffy";

		sops-nix.url = "github:Mic92/sops-nix";

		emacs-overlay.url = "github:nix-community/emacs-overlay";
	}; 

	outputs = {
		nixpkgs,
		home-manager,
		sops-nix,
		antigravity-nix,
		emacs-overlay,
		luffy,
		...
	}@inputs:
	let
    # Nota: Ajusta las rutas si tu estructura de carpetas es distinta desde la raíz del flake
		system = "x86_64-linux";
    scriptsPath = ./home/scripts; 
    myModulesPath = ./home/modules;
		confilePath = ./home/modules/confiles; 
	in
	{
		# Configuración del sistema NixOS (requiere sudo) 
		nixosConfigurations.Dante-NixOS = nixpkgs.lib.nixosSystem { 
			inherit system;

      specialArgs = { 
				inherit inputs; 
				inherit scriptsPath myModulesPath confilePath;
			};

			modules = [
				./hardware-configuration.nix 
				./configuration.nix
				home-manager.nixosModules.home-manager # Módulo de home-manager en la configuración de NixOS

				{

					home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

					# Esto pasa los argumentos de NixOS (specialArgs) a Home Manager
          home-manager.extraSpecialArgs = { 
            inherit inputs scriptsPath myModulesPath confilePath;
          };

          environment.systemPackages = [
            inputs.antigravity-nix.packages.x86_64-linux.default
						inputs.luffy.packages.${system}.luffy
          ];
          nixpkgs.config.allowUnfree = true;
        }
				{
				# Configuración de Home Manager directamente aquí dentro de NixOS
					home-manager.users.ponnshe = {
					# Incluye la configuración del usuario desde home/default.nix
						imports = [ ./home/default.nix ];
						# Overlay específico para el usuario
					};
				} 
			];
		};
	};
}
