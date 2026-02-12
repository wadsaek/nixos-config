{ pkgs, ... }:
{
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   enableBrowserSocket = true;
  # };

  # programs.gnupg.dirmngr = {
  #   enable = true;
  # };

  programs.yubikey-touch-detector = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnupg
    openssh
    yubikey-manager
    yubioath-flutter
  ];
  services.pcscd.enable = true;
}
