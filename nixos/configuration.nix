# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      backupFileExtension = "backup";
      extraSpecialArgs = {inherit inputs;};
      users = {
        wadsaek = import ./home.nix;
      };
    };
#allows?
  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      #useOSProber = true;
      default ="saved";
      theme = "${
        (pkgs.fetchFromGitHub{
          owner = "OliveThePuffin";
          repo = "yorha-grub-theme";
          rev = "4d9cd37baf56c4f5510cc4ff61be278f11077c81";
          sha256 = "sha256-XVzYDwJM7Q9DvdF4ZOqayjiYpasUeMhAWWcXtnhJ0WQ=";
        })
      }/yorha-1920x1080";
    };
  };

  networking.hostName = "Esther"; # Define your hostname.
  networking.wireless.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    unmanaged = ["*" "except:type:wwan" "except:type:gsm"];
  };

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IL";
  i18n.supportedLocales = [
    "he_IL.UTF-8/UTF-8"
    "uk_UA.UTF-8/UTF-8"
    "en_IL/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "he_IL.UTF-8";
    LC_IDENTIFICATION = "he_IL.UTF-8";
    LC_MEASUREMENT = "he_IL.UTF-8";
    LC_MONETARY = "he_IL.UTF-8";
    LC_NAME = "he_IL.UTF-8";
    LC_NUMERIC = "he_IL.UTF-8";
    LC_PAPER = "he_IL.UTF-8";
    LC_TELEPHONE = "he_IL.UTF-8";
    LC_TIME = "he_IL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.resolutions = [{
    x = 1920;
    y = 1080;
  }];
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  xdg.portal.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    videoDrivers = ["nvidia"];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wadsaek = {
    isNormalUser = true;
    description = "Esther Barenboim";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJARJLouxL6ZT9OHKcroCPp/2mdTQkYHFL3ARSYvQyWemWrEKQp/gJr0WpCMIBi5bRUSCO5l7NptWZKKdfmV5a9RSJZjZCpduTIOXWItEJrtAVleo1Zz7MKczhO78LYBQzJoLozpDQjIDJVXuFoF8WxZgOxvjtKBPu0Ff7BDqaUeW9Kpp4lhsWHa9UfY+wuzf0mk6ehyGmf9ee2YuZNwHj0mpsq4YoFdoqOiiHATjz0vpqba0ofNDiGf0FaQAUgIz3uCLOcFQs2w5/ovfM4n24gym3L9943x4CAgMB2EQqqaW+0uKg5mBDtRlPCAq8QlHOKj2EuT3P6UINwHeSv4y5UOgfU3qQXG0p8vz7kyJjlkmcEpanT69J3tx3rJOk22CzSosCbPq19N0qxmAlcabXeh0zCNLzRWPI/BrhDAaqyYmGjPFdTBVeoUrqzUxKkPXOiQSiWAqqT1ZquerAXeyB4aP+eIEL0f88G3m2RWSFXWEnv/23JhncKjYwCrpqozFA6XOfciaaCiaOuvb2b66aFwOnq2YYIrdeCt1p/SYoBIV5J7CnSLlAf3kNwpP9hNdKn1sxN2bwQ7BeKRVSOW94sAdFMfv7aPOoUSpviIyeBkvHFG8zcQkFTHpbWUoWkoQu2EjQJI9t9m8eEoi28BBtIjy5IyIlas3/aQWHkO6NBw== wadsaek"
    ];
  };
  users.defaultUserShell = pkgs.nushell;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nixpkgs.config.permittedInsecurePackages = [
            "electron-25.9.0"
            ];
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    #dependencies
    glibc
    libnotify

    #nixos
    home-manager

    #neovim
    neovim
    vimPlugins.packer-nvim
    
    #fun
    lolcat
    blahaj
    cowsay
    ani-cli

    #cli
    lf
    spotify-player 
    alacritty
    bat
    fastfetch
    ripgrep
    zellij
    mprocs
    asciiquarium
    cmatrix
    fzf
    
    obsidian
    spotify
    davinci-resolve
    gimp
    libreoffice-qt
    grim
    opera
    
    #gaming
    heroic
    mangohud
    protonup

    tg   
    discord
    betterdiscordctl
    zapzap
    whatsapp-for-linux
    telegram-desktop
    playerctl

    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    }))
    mpd
    mako
    wpaperd
    rofi-wayland
    blueman
    kdePackages.dolphin
    kdePackages.partitionmanager
    rose-pine-cursor
    networkmanagerapplet

    #general programming
    gccgo14
    docker_27
    sqlcmd

    #rust
    rustup
    cargo-watch
    trunk
    sccache

    #haskell
    ghc

    #version control
    github-desktop
    gh

    #cs
    roslyn
    dotnet-sdk_8
    
    #gamedev
    godot_4

    #js
    nodejs_22
    sass
    nodePackages.pnpm

    #python
    python312
    python312Packages.requests

    #  wget
    (vscode-with-extensions.override {
      	vscodeExtensions = with vscode-extensions; [
          bbenoist.nix
          ms-python.python
	  ms-azuretools.vscode-docker
	  #github.codespaces

          #csharp
          ms-dotnettools.csdevkit
          ms-dotnettools.csharp
          ms-dotnettools.vscode-dotnet-runtime
          #ormulahendry.dotnet

          #rust
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
          
	  justusadam.language-haskell
	  haskell.haskell

          esbenp.prettier-vscode
	  vscodevim.vim
	] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
	    name = "vscode-tidalcycles";
	    publisher = "tidalcycles";
	    version = "1.4.1";
    	    sha256 = "sha256-pT9MwjS4Kn90VuTYfl82mGQuSNtD8tKc3h0jccz+EBI=";
     	  }
          {
            name = "remote-ssh-edit";
            publisher = "ms-vscode-remote";
    	    version = "0.47.2";
    	    sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
     	  }
          {
            name = "rust-syntax";
            publisher = "dustypomerleau";
            version = "0.6.1";
            sha256 = "a3d8973e1c248a6c6825cd5d2dd689f270722c86894a9197fe72842c2dba8c65";
          }
          {
            name = "errorlens";
            publisher = "usernamehw";
            version = "3.17.0";
            sha256 = "134100cd8ba46a2bbf0ca44410fe074234573c0ab007870fd8fc0cd41ddcd289";
          }
          {
            name = "es7-react-js-snippets";
            publisher = "dsznajder";
            version = "4.4.3";
            sha256 = "405f79d0986f5486ad840ca0bdadf0c143b304b8c19bb1c4dd281ca7b7f6d0f7";
          }
          {
            name = "bootstrap5-vscode";
            publisher = "AnbuselvanRocky";
            version="0.4.4";
            sha256 = "51030f8103f3fdc77399328804490ff162c2777041f325133c79af4871ed33cf";
          }
          {
            name = "hotrice";
            publisher = "wadsaek";
            version = "0.1.0";
            sha256= "ea24fceace36489b20dace157bd221f32ececcf8614655346a7c939b3e18e419";
          }
          {
            name = "todo-tree";
            publisher = "gruntfuggly";
            version = "0.0.226";
            sha256= "sha256-Fj9cw+VJ2jkTGUclB1TLvURhzQsaryFQs/+f2RZOLHs=";
          }
	  {
	    name = "dependi";
	    publisher = "fill-labs";
            version = "0.7.4";
            sha256= "sha256-6nU0bVAe/vwq43ECLwypIkMAG/q5+P2bE1RPAjeTCX4=";
          }
     	];
      })
  ]) ++ (with pkgs.haskellPackages; [
    tidal
  ]);

  fonts.packages = with pkgs;[
    fira-code
    nerdfonts
    siji
  ];
  environment.sessionVariables ={
    NIXOS_OZONE_WL = "1";
  };



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs = {
  	steam = {
    	    enable = true;
    	    remotePlay.openFirewall = true;
    	    dedicatedServer.openFirewall = true;
          gamescopeSession.enable = true;
  	};
    gamemode.enable = true;
  	zsh.autosuggestions.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    logitech.wireless.enable = true;
    graphics = {
      enable = true;
      extraPackages =  [pkgs.libvdpau-va-gl ];
      enable32Bit = true;
    };
    nvidia= {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      prime = {
        sync.enable = true;

        #intel integrated
        intelBusId = "PCI:0:2:0";

        #nvidia dedicated
        nvidiaBusId = "PCI:1:0:0";
      };
    };
};


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = ["wadsaek"];
      UseDns = false;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };
  virtualisation.docker = {
    enable = true;
  };
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["wadsaek"];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 5173 ];
  networking.firewall.allowedUDPPorts = [ 22 5173 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
