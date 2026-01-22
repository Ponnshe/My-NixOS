# NixOS Configuration - Dante-NixOS

Configuración declarativa para NixOS utilizando **Flakes** y **Home Manager**.

## Estructura del Proyecto

Esta configuración sigue una filosofía de "Entorno Base Limpio". No instalamos herramientas de desarrollo (Compiladores, SDKs) a nivel de sistema. En su lugar, utilizamos plantillas de Flakes ubicadas en la carpeta `flakes/`.

*   `flake.nix`: Entrada principal del sistema.
*   `configuration.nix`: Configuración del sistema base (Boot, Drivers, Servicios).
*   `home/`: Configuración de usuario (Dotfiles, Neovim, Hyprland).
*   `flakes/`: **Plantillas de Entornos de Desarrollo**.

## Uso Diario

### 1. Actualizar el Sistema
Para aplicar cambios en la configuración de NixOS o Home Manager:

```bash
sudo nixos-rebuild switch --upgrade --flake ~/nixos-config#Dante-NixOS --show-trace
```

### 2. Iniciar un Nuevo Proyecto de Desarrollo

No instales `python`, `rust` o `java` globalmente. Usa las plantillas locales:

**Python:**
```bash
mkdir mi-proyecto && cd mi-proyecto
nix flake init -t path:~/nixos-config/flakes/python
direnv allow
```

**Rust:**
```bash
mkdir mi-proyecto && cd mi-proyecto
nix flake init -t path:~/nixos-config/flakes/rust
direnv allow
```

**Java:**
```bash
mkdir mi-proyecto && cd mi-proyecto
nix flake init -t path:~/nixos-config/flakes/java
direnv allow
```

Al hacer esto, `direnv` activará automáticamente el entorno con las herramientas necesarias (LSP, Compiladores, Formateadores) solo en esa carpeta.

## Notas Importantes

*   **Neovim:** Abre Neovim *dentro* de la carpeta del proyecto una vez que el entorno se haya cargado. Neovim usará las herramientas (LSP) provistas por el flake del proyecto.
*   **Limpieza:** El sistema ejecuta Garbage Collection semanalmente. Puedes forzarlo con `nix-collect-garbage -d`.