{
  description = "Minimal reproducible Python dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Definimos la versión de Python y paquetes globales si fueran necesarios
        # (Equivalente a tu toolchain de Rust)
        python = pkgs.python3; 
        
      in {
        devShells.default = pkgs.mkShell {
          name = "python-dev-shell";

          packages = with pkgs; [
            python
            # Herramientas de desarrollo (Equivalentes a rust-analyzer/clippy)
            basedpyright  # LSP potente (alternativa: python-lsp-server)
            ruff          # Linter y Formatter extremandamente rápido
            uv            # Opcional: Gestor de paquetes moderno (reemplazo de pip/poetry)
          ];

          # Variables de entorno
          env = {
            PYTHONUNBUFFERED = "1";
            # Ayuda a que pip encuentre librerías de C si compilas cosas nativas
            LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib"; 
          };

          # Hook para crear/activar un entorno virtual automáticamente (Opcional pero recomendado)
          shellHook = ''
            if [ ! -d ".venv" ]; then
              echo "Creando entorno virtual (.venv)..."
              ${python}/bin/python -m venv .venv
            fi
            source .venv/bin/activate
            echo "🐍 Entorno Python activo con $(python --version)"
          '';
        };
      });
}
