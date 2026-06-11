# NixOS Configuration - Dante-NixOS

## Project Overview
This repository contains the declarative system configuration for a NixOS system, specifically for the host **Dante-NixOS** and user **ponnshe**. It utilizes **Nix Flakes** for reproducible dependency management and **Home Manager** for managing user-specific dotfiles and packages.

**Core Philosophy: Zero Global Dev Tools.**
Unlike traditional Linux distros, this configuration avoids installing compilers (Rust, GCC, Java) or runtime environments (Python, Node) globally. Instead, it relies on project-specific **Flakes** to provide reproducible development environments on demand.

The system is designed as a developer workstation with a focus on:
*   **Window Manager**: Hyprland (Wayland)
*   **Shell**: Zsh + Direnv (for automatic environment loading)
*   **Editors/IDEs**: Neovim (primary), Emacs
*   **Virtualization**: Docker
*   **Secrets Management**: sops-nix

## Architecture

*   **`flake.nix`**: System entry point. Defines inputs and system outputs.
*   **`configuration.nix`**: Base system config (Boot, Kernel, Services, Hardware, Secrets).
*   **`home/`**: Home Manager user configuration.
    *   **`home/default.nix`**: User entry point. Loads all personal packages and programs.
    *   **`home/modules/`**: Modular configs for apps (Hyprland, Nvim, Zsh, Zellij, Foot, Emacs, etc.).
    *   **`home/scripts/`**: User-specific utility scripts.
*   **`flakes/`**: **Development Environments (Templates)**.
    *   `flakes/rust/`: Rust toolchain + Analyzer.
    *   `flakes/python/`: Python + Data Science tools + LSP.
    *   `flakes/java/`: JDK + Maven/Gradle + Custom JDTLS wrapper.
    *   `flakes/low_level/`: C/C++ + Debugging tools (GDB, Valgrind).
*   **`secrets.yaml`**: Encrypted secrets managed by sops.

## Key Commands

### System Updates
To apply changes to the system configuration:
```bash
sudo nixos-rebuild switch --upgrade --flake ~/nixos-config#Dante-NixOS --show-trace
```

### Starting a New Project
Don't install tools globally. Instead, initialize a flake from the local templates:

**Python Project:**
```bash
nix flake init -t path:~/nixos-config/flakes/python
direnv allow
```

**Rust Project:**
```bash
nix flake init -t path:~/nixos-config/flakes/rust
direnv allow
```

**Java Project:**
```bash
nix flake init -t path:~/nixos-config/flakes/java
direnv allow
```

## Configuration Highlights

### System (`configuration.nix`)
*   **Clean System**: No heavy dev tools in `systemPackages`.
*   **Boot**: GRUB (Xenlism theme) + Plymouth (Lone theme).
*   **Kernel**: Latest Linux kernel optimized for AMDGPU.
*   **Services**: Matrix-Conduit, Mautrix-Whatsapp bridge, Caddy, Docker.

### User (`home/default.nix`)
*   **Safe Environment**: No global `LD_LIBRARY_PATH` or `PYTHONPATH` to prevent conflicts.
*   **Editors**: Neovim is configured to inherit tools (LSPs, Formatters) from the active `nix develop` shell or `direnv` context. Emacs is also available.
*   **Terminal & Multiplexer**: Foot and Zellij.

## Development Conventions
1.  **Never install compilers globally.** Use `nix develop` or `direnv`.
2.  **Editor Flow:** Always open your editor (e.g., Neovim) *after* loading the project environment (via `direnv`). This ensures LSPs are available in the PATH.
3.  **Secrets/State**: Secrets are managed via `sops-nix`. `system.stateVersion` = `23.11`.
4.  **Garbage Collection**: The system executes weekly automatic garbage collection. Manually force it with `nix-collect-garbage -d`.