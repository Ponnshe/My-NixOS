{
  description = "RustyRTC";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };

        rust = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "clippy" "rustfmt" ];
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "rust-dev-shell";

          # --- HERRAMIENTAS DE COMPILACIÓN ---
          nativeBuildInputs = with pkgs; [
            pkg-config
            cmake
            llvmPackages.llvm
            llvmPackages.clang  # Necesario para compilar el código C++ generado
            rust
            rust-analyzer
          ];

          # --- LIBRERÍAS (.so) ---
          buildInputs = with pkgs; [
            alsa-lib
            opencv
            openssl
            llvmPackages.libclang
            llvmPackages.libcxx # A veces ayuda explícitamente
          ];

          # --- VARIABLES DE ENTORNO ---
          env = {
            RUST_BACKTRACE = "1";
            
            # 1. Ruta para encontrar libclang.so
            LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
            
            # 2. Rutas para pkg-config
            PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

            # 3. LA SOLUCIÓN A TU ERROR 'memory not found':
            # Le decimos a Bindgen explícitamente dónde están los headers de C++ (libstdc++)
            BINDGEN_EXTRA_CLANG_ARGS = builtins.concatStringsSep " " [
              "-isystem ${pkgs.llvmPackages.libclang.lib}/lib/clang/${pkgs.llvmPackages.libclang.version}/include"
              "-isystem ${pkgs.lib.getDev pkgs.stdenv.cc.cc}/include/c++/${pkgs.stdenv.cc.cc.version}"
              "-isystem ${pkgs.lib.getDev pkgs.stdenv.cc.cc}/include/c++/${pkgs.stdenv.cc.cc.version}/${system}-gnu" # Ajuste para arquitectura
              "-isystem ${pkgs.glibc.dev}/include"
            ];
          };
          
          # Depuración opcional: imprime las rutas al entrar para verificar
          shellHook = ''
            echo "Environment loaded."
            echo "BINDGEN args: $BINDGEN_EXTRA_CLANG_ARGS"
          '';
        };
      });
}
