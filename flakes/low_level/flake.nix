{
  description = "Low Level Dev Environment: Rust + C + Debugging Tools";

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

        # 1. Configuración de Rust
        # Incluimos 'rust-src' obligatoriamente para que rust-analyzer pueda
        # navegar al código fuente de la std lib (syscalls, fs, io, etc).
        rust-toolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "clippy" "rustfmt" ];
        };

      in {
        devShells.default = pkgs.mkShell {
          name = "low-level-shell";

          # 2. Dependencias de compilación nativas
          # A veces necesarias si compilas crates que wrappean librerías de C (como openssl-sys)
          nativeBuildInputs = with pkgs; [
            pkg-config
          ];

          # 3. Paquetes del entorno
          packages = with pkgs; [
            # --- Rust ---
            rust-toolchain
            rust-analyzer

            # --- C / C++ Toolchain ---
            gcc          # El compilador estándar (puedes cambiarlo por clang)
            gnumake      # Para Makefiles
            cmake        # Build system común en C/C++
						llvmPackages_20.clang-tools

            # --- Depuración y Análisis (CRÍTICO para bajo nivel) ---
            gdb          # El depurador estándar de GNU
            valgrind     # Para detectar memory leaks en C
            strace       # Muestra las syscalls que hace tu programa (útil para ver el fork)
            ltrace       # Muestra las llamadas a librerías dinámicas
            binutils     # Herramientas: objdump (ver asm), readelf, nm, size

            # --- Documentación ---
            man-pages    # Manuales de Linux (necesario para 'man fork', 'man 2 write', etc.)
            man-db       # El visor de manuales
          ];

          # 4. Variables de Entorno
          env = {
            RUST_BACKTRACE = "1";
            
            # Ayuda a rust-analyzer y editores a encontrar el código fuente de Rust
            RUST_SRC_PATH = "${rust-toolchain}/lib/rustlib/src/rust/library";
            
            # Asegura que pkg-config encuentre las librerías del sistema
            PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
          };

          # Mensaje de bienvenida opcional
          shellHook = ''
            echo "🛠️  Entorno Low Level Activado"
            echo "   - Rust $(rustc --version)"
            echo "   - GCC $(gcc --version | head -n1)"
            echo "   - Usa 'strace ./tu_programa' para ver las syscalls"
          '';
        };
      });
}
