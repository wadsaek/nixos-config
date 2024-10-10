{ inputs, lib, config, pkgs, ... }:

{
  imports =
    [
      ./cachix/cachix.nix
      ./services
      ./packages/envPackages.nix
      ./nvidia.nix
      ./essentials/essentials.nix
      ./general-options.nix
      ./qoa
      ./display
    ];
  networking.hostName = config.hostName;

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
    # videoDrivers = ["nvidia"];
  };

  services.printing.enable = true;

  users.users.wadsaek = {
    isNormalUser = true;
    description = "Esther Barenboim";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      zsh
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJARJLouxL6ZT9OHKcroCPp/2mdTQkYHFL3ARSYvQyWemWrEKQp/gJr0WpCMIBi5bRUSCO5l7NptWZKKdfmV5a9RSJZjZCpduTIOXWItEJrtAVleo1Zz7MKczhO78LYBQzJoLozpDQjIDJVXuFoF8WxZgOxvjtKBPu0Ff7BDqaUeW9Kpp4lhsWHa9UfY+wuzf0mk6ehyGmf9ee2YuZNwHj0mpsq4YoFdoqOiiHATjz0vpqba0ofNDiGf0FaQAUgIz3uCLOcFQs2w5/ovfM4n24gym3L9943x4CAgMB2EQqqaW+0uKg5mBDtRlPCAq8QlHOKj2EuT3P6UINwHeSv4y5UOgfU3qQXG0p8vz7kyJjlkmcEpanT69J3tx3rJOk22CzSosCbPq19N0qxmAlcabXeh0zCNLzRWPI/BrhDAaqyYmGjPFdTBVeoUrqzUxKkPXOiQSiWAqqT1ZquerAXeyB4aP+eIEL0f88G3m2RWSFXWEnv/23JhncKjYwCrpqozFA6XOfciaaCiaOuvb2b66aFwOnq2YYIrdeCt1p/SYoBIV5J7CnSLlAf3kNwpP9hNdKn1sxN2bwQ7BeKRVSOW94sAdFMfv7aPOoUSpviIyeBkvHFG8zcQkFTHpbWUoWkoQu2EjQJI9t9m8eEoi28BBtIjy5IyIlas3/aQWHkO6NBw== wadsaek"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCaXeIqPrDpj3WJMlqGVxxG8a6puAErL0bwOAJG+P70nhaMBHodKKqwfpmbD0ZDnr4RV/umjTElC0QBjBsMJKc2ghQMIkVSVCPNE1jF6suMAG2HKFA1bcpToGag8ZzurNCEhxE1ChzTa+USrWObxSVe7do0KgFgxgedUUoKF2M870psJWDu+dhtCNUNK3lMx1Gx4xK1BYt2vKLxQ/tjEMULjDGeo92KYzYoPBpSV1PXF7M8R/Pjc+FP4ej4DVhJAV2S5ED68RO+eT87paihUhCYvjreXq5HiaPXVzb9MufsykK2xMiBekwM8ndSFuZGUaADaCW+gtJaC2Hq41oWOhnx2t45L//6OCaPoDNeGpQ1z5y8lbdQ9KaGTmWGfV1H2g8XrloFs6W7ENQfCnepVPGSqqxlKNBdOeoUsqOnx/rw6QnZ2FL5w4K4UMFXdtNk+jiazCFcaLg2gDZBwsY+R/OPokF58L1pUGmMaBM5LIIXb2zLnQEFWnEANNCq9W8RxvhDbQB+HbV5l1Rhvco4ZJwT/vz+mS3zVcwNpouipkSKF6AlKOcVd0MVNbx+Oo9ytM/AgY8DUK3BsN740jwdQbiWMaUzZ3C/YCzOQE/VeS4XuO6B5aQGc3hiOYt9nygFjyQFbPgQLJU1RFmsbrMeClZ3AWLqaD93u/AO6eDdTNpeww== wadsaek"
    ];
  };
  programs.zsh.enable = true;
  programs.zsh.autosuggestions.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Install firefox.
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
            "electron-25.9.0"
            ];
  nix.settings.experimental-features = ["nix-command" "flakes"];

  fonts.packages = with pkgs;[
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
	gamescope = {
	  enable = true;
	  capSysNice = true;
	};
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

  networking.firewall.allowedTCPPorts = [ 22 5173 8081 7062 5298 3000];
  networking.firewall.allowedUDPPorts = [ 22 5173 8081 7062 5298];

  system.stateVersion = "24.05";
}
