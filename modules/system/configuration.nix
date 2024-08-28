# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [
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

  networking.networkmanager = {
    enable = true;
    unmanaged = ["*" "except:type:wwan" "except:type:gsm"];
  };

  time.timeZone = "Asia/Jerusalem";
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

  #services.xserver.enable = true;
  
  services.xserver.resolutions = [{
    x = 1920;
    y = 1080;
  }];
  services.desktopManager.plasma6.enable = true;
  #services.displayManager.sddm = {
  #  enable = true;
  #  wayland.enable = true;
  #};
  #services.xserver.displayManager.startx.enable = false;
  services.xserver.displayManager = {
    session = [
      {
	manage = "desktop";
	name = "hyprland";
	start = ''
	  ${pkgs.hyprland}/bin/Hyprland 
	  $env.WaitPID=$!
	'';
      }
    ];
  };
  xdg.portal.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    videoDrivers = ["nvidia"];
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
            "electron-25.9.0"
            ];
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = import ./envPackages.nix;
  fonts.packages = with pkgs;[
    fira-code
    nerdfonts
    siji
  ];

  environment.sessionVariables ={
    NIXOS_OZONE_WL = "1";
  };

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
};


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

  networking.firewall.allowedTCPPorts = [ 22 5173 ];
  networking.firewall.allowedUDPPorts = [ 22 5173 ];

  system.stateVersion = "24.05";
}