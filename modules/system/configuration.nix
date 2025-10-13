{
  system,
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./cachix/cachix.nix
    ./services
    ./packages/envPackages.nix
    ./essentials/essentials.nix
    ./general-options.nix
    ./qoa
    ./display
    ./security
    ./steam.nix
    ./fonts.nix
    ./documentation.nix
  ];
  networking.hostName = config.hostName;

  time.timeZone = "Asia/Jerusalem";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [
    "he_IL.UTF-8/UTF-8"
    "uk_UA.UTF-8/UTF-8"
    "en_IL/UTF-8"
  ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IL";
    LC_IDENTIFICATION = "en_IL";
    LC_MEASUREMENT = "en_IL";
    LC_MONETARY = "en_IL";
    LC_NAME = "en_IL";
    LC_NUMERIC = "en_IL";
    LC_PAPER = "en_IL";
    LC_TELEPHONE = "en_IL";
    LC_TIME = "en_IL";
  };

  services.xserver.resolutions = [
    {
      x = 1920;
      y = 1080;
    }
  ];
  xdg.portal.enable = true;

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.printing.enable = true;

  users.users.wadsaek = {
    isNormalUser = true;
    description = "Esther Barenboim";
    extraGroups = [
      "networkmanager"
      "wheel"
    ]
    ++ lib.optional config.steam.enable "gamemode";

    shell = pkgs.zsh;
    packages = with pkgs; [
      zsh
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJARJLouxL6ZT9OHKcroCPp/2mdTQkYHFL3ARSYvQyWemWrEKQp/gJr0WpCMIBi5bRUSCO5l7NptWZKKdfmV5a9RSJZjZCpduTIOXWItEJrtAVleo1Zz7MKczhO78LYBQzJoLozpDQjIDJVXuFoF8WxZgOxvjtKBPu0Ff7BDqaUeW9Kpp4lhsWHa9UfY+wuzf0mk6ehyGmf9ee2YuZNwHj0mpsq4YoFdoqOiiHATjz0vpqba0ofNDiGf0FaQAUgIz3uCLOcFQs2w5/ovfM4n24gym3L9943x4CAgMB2EQqqaW+0uKg5mBDtRlPCAq8QlHOKj2EuT3P6UINwHeSv4y5UOgfU3qQXG0p8vz7kyJjlkmcEpanT69J3tx3rJOk22CzSosCbPq19N0qxmAlcabXeh0zCNLzRWPI/BrhDAaqyYmGjPFdTBVeoUrqzUxKkPXOiQSiWAqqT1ZquerAXeyB4aP+eIEL0f88G3m2RWSFXWEnv/23JhncKjYwCrpqozFA6XOfciaaCiaOuvb2b66aFwOnq2YYIrdeCt1p/SYoBIV5J7CnSLlAf3kNwpP9hNdKn1sxN2bwQ7BeKRVSOW94sAdFMfv7aPOoUSpviIyeBkvHFG8zcQkFTHpbWUoWkoQu2EjQJI9t9m8eEoi28BBtIjy5IyIlas3/aQWHkO6NBw== wadsaek"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDtBAviGNBpLcjPYOUcHzRVli70rOsemmXl0f2Kgi9Q/ wadsaek@gmail.com"
    ];
  };

  users.groups = {
    uinput.members = [ "wadsaek" ];
    input.members = [ "wadsaek" ];
    plugdev.members = [ "wadsaek" ];
  };

  programs.zsh.enable = true;
  programs.zsh.autosuggestions.enable = true;
  users.defaultUserShell = pkgs.zsh;

  nixpkgs = import ../../nixpkgs.nix { inherit inputs system; };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  programs.nix-ld = {
    enable = true;
  };

  environment.sessionVariables = {
    GSK_RENDERER = "ngl";
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
  };

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    logitech.wireless.enable = true;
    graphics = {
      enable = true;
      extraPackages = [ pkgs.libvdpau-va-gl ];
      enable32Bit = true;
    };
    uinput.enable = true;
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "wadsaek" ];
      UseDns = false;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "wadsaek" ];

  networking.firewall.allowedTCPPorts = [
    22
    5173
    8081
    7062
    5298
    3000
    22000
  ];
  networking.firewall.allowedUDPPorts = [
    22
    5173
    8081
    7062
    5298
    21027
    22000
  ];

  system.stateVersion = "24.05";
}
