# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
    xenlism-grub-theme = pkgs.fetchFromGitHub
    {
        owner = "Arkachur";
        repo = "NixOS-grub-theme";
        rev = "5309fdf51374af71a34a4caf9ee2f290a86c5a61";
        sha256 = "sha256-LNT1SKxQDvdHzsOCMSA0aTBM5TY3/ReLLVCVS+9hgh8=";
    };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./hosts.nix
    ];

    #Nix-Flakes


    # Boot Module.
  boot = {
    loader.grub= {
      enable = true;
      devices = [ "nodev" ];
      efiInstallAsRemovable = true;
      efiSupport = true;
      useOSProber = true;	
      configurationLimit = 5;
      theme = xenlism-grub-theme;
      gfxmodeEfi = "1920x1080";
    };
    kernelParams = [
      "quiet"           # Oculta la mayoría de los mensajes
      "splash"          # Habilita la pantalla de splash
      "loglevel=3"      # Nivel de logs (0=emergencia, 7=debug)
      "vt.global_cursor_default=0"  # Oculta el cursor parpadeante
      "console=tty1"    # Redirige mensajes a TTY1 (opcional)
    ];
    plymouth = {
      enable = true;
      theme = "lone";

      themePackages = [
        (pkgs.stdenv.mkDerivation {
        name = "plymouth-theme-lone";
        src = ./plymouth-themes/lone;  # ✅ Ruta relativa al flake


      installPhase = ''
          mkdir -p $out/share/plymouth/themes/lone
          cp -r $src/* $out/share/plymouth/themes/lone/

          # Corregir rutas en el archivo .plymouth
          substituteInPlace $out/share/plymouth/themes/lone/lone.plymouth \
          --replace "/usr/share/plymouth/themes/lone" "$out/share/plymouth/themes/lone"
        '';
        })
      ];
    };
    initrd.kernelModules = [ 
      "amdgpu"    # Para AMD
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = ["snd_aloop" "kvm-intel" "hid-nintendo" "v4l2loopback" ];
    extraModprobeConfig = ''
      options snd-aloop index=1
    '';
  };

  programs.zsh.enable = true;  # Habilita zsh a nivel de sistema

   # boot.plymouth = {
   #     enable = true;
   #     theme = "proxzima";        # Tema básico (hay otros como "bgrt", "breeze", etc.)
   #     themePackages = [ pkgs.plymouth-proxzima-theme ];  # Paquete de temas adicionales
   # };

  #Users Module
  users = {
    defaultUserShell = pkgs.zsh;
    groups.plugdev = {};

    users.ponnshe = {
      isNormalUser = true;
      description = "NervoOlalla";
      extraGroups = ["plugdev" "networkmanager" "wheel" "video" "audio" "docker" "adbusers" "udev" "wireshark"];
    };
  };


  #Programs Module
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    light.enable = true;
    waybar.enable = true;
    xfconf.enable = true;
    wshowkeys.enable = true;
		adb.enable = true;
		wireshark.enable = true;
		wireshark.package = pkgs.wireshark;
  };


  # Hardware Module
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit= true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    fancontrol.enable = false;
  };

  # Systemd module


  systemd={
    services={
      NetworkManager-wait-online.enable = false;
      docker = {
        enable = true;
      };
    };
  };

  #More Modules

  #zramSwap Module
  zramSwap = {
    enable = true;
		algorithm = "zstd"; # El mejor algoritmo de compresión actual
		memoryPercent = 50; # Usar hasta el 50% de tu RAM para compresión
  };


  # Desktop Portals
  xdg = {
    portal.enable = true;
    portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };


  # Sound with Pipewire
  security = {
	  rtkit.enable = true;
		pam.services.hyprland.enableGnomeKeyring = true;
	};

  # Network Module
  networking.hostName = "Dante-NixOS"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "America/Argentina/Buenos_Aires";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
      LC_ADDRESS = "es_AR.UTF-8";
      LC_IDENTIFICATION = "es_AR.UTF-8";
      LC_MEASUREMENT = "es_AR.UTF-8";
      LC_MONETARY = "es_AR.UTF-8";
      LC_NAME = "es_AR.UTF-8";
      LC_NUMERIC = "es_AR.UTF-8";
      LC_PAPER = "es_AR.UTF-8";
      LC_TELEPHONE = "es_AR.UTF-8";
      LC_TIME = "es_AR.UTF-8";
  };

  # Configure keymap in X11
  #Console Key Map
  console = {
    useXkbConfig = true;
  };


  #Define a user account. Don't forget to set a password with ‘passwd’.

  #Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
			"qtwebengine-5.15.19"
			"python-2.7.18.8"
    ];
  };

  #Virtualisation Module
  virtualisation = {
    docker = { #Docker Module
      enable = true; #Cambiar a true para activar docker
      rootless = {
        enable = false;				#Cambiar a true para activar docker
        setSocketVariable = true;
      };
    };
		vswitch = {
		  enable = true;
		};
  };


  #Packages
  environment.systemPackages = with pkgs; [
	    xterm
			xhost
			wireshark
			termshark

      plantuml

      powertop
      usbutils
      graphviz
      ffmpeg

      #Sensores de temp, fans, etc
      lm_sensors

      # Control Celular
      scrcpy
      android-tools

      #Fondo animado
      mpvpaper

      #Entertainment
      #stremio

      #For docker
      gnome-keyring

      #WebBrowsers
      firefox 
      vivaldi

      emacs

      jq			#Json Proccessor?
      xdg-desktop-portal	#Interfaz de apps para interactuar con el sistema
      wl-clipboard

      git
      picom		#transparency

      nitrogen 	#Ver fotos

      kitty 		#terminal

      #Notificaciones
      dunst 	#Interfaz
      libnotify 	#Generacion

      xdg-desktop-portal-gnome

      #Control Audio
      pavucontrol	#Interfaz
      pamixer		#Comando

      #Control de redes
      pkgs.networkmanagerapplet	#Manejo de redes barra de estado(aprender)
      networkmanager

      #Lector PDF
      zathura
      mupdf

      obsidian
      file

      #Herramientas de Sistema
      htop
      alsa-utils
      imagemagick   	 #Edicion imagenes (Aprender)
      killall	      	 #Detener Procesos
      brightnessctl 	 #Brillo
      lsof         	 #Listar servicios
      zip	     	 #Zippear
      unzip	     	 #Descomprimir
      grim         	 #Tomar capturas de pantalla
      wget	     	 #Obtener Archivos desde la red
      slurp		 #Complemento para capturar pantalla. Coords

      #Misc
      neofetch	#Mensaje de bienvenida consola
      cowsay		
      lolcat
      fortune

  ];

  fonts.packages= with pkgs; [
    nerd-fonts.hack
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services = {
    mysql = {
        enable = false;		#Cambiar a true para usar mysql
        package = pkgs.mariadb;
    };

		gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    blueman.enable = true;
    xserver = {
      enable = true;
      xkb= {
        layout = "latam";
        variant = "";
        options = "ctrl:nocaps";
      };
    };
    auto-cpufreq.enable = true;
    udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="xxxx", MODE="0666", GROUP="plugdev"
    '';
    gvfs.enable = true;
    tumbler.enable = true;
    openssh.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
      };
    };
		dbus = {
		  enable = true;
		};
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
	networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 5005 ];
    # allowedTCPPorts = [ 80 443 ];  # Ejemplo para TCP si lo necesitaras
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?


  #Auto Upgrading
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  # Collection Garbage
  nix = {
    settings = {
	auto-optimise-store = true;   
	experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
