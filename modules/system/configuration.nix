{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./cachix/cachix.nix
    ./services
    ./packages
    ./essentials
    ./general-options.nix
    ./qoa
    ./display
    ./security
    ./steam.nix
    ./fonts.nix
    ./documentation.nix
    ./etc
    ./users
    ./virtualization
  ];

  networking.hostName = config.hostName;

  xdg.portal.enable = true;

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.printing.enable = true;

  environment.sessionVariables = {
    GSK_RENDERER = "ngl";
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

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "wadsaek" ];

  networking.firewall.allowedTCPPorts = [
    5173
    8081
    7062
    5298
    3000
    22000
  ]
  ++ config.services.openssh.ports;

  networking.firewall.allowedUDPPorts = [
    21027
    22000
  ];

  system.stateVersion = "24.05";
}
