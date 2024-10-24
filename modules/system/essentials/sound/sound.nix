{ lib, ... }:
{
  imports = [
    ./pipewire.nix
    ./pulseaudio.nix
  ];
  options = {
    audio = lib.mkOption {
      type = lib.types.enum [
        "pipewire"
        "pulseaudio"
        null
      ];
      default = "pipewire";
      description = "Which audio provider to enable";
    };
  };
  config = {
    security.rtkit.enable = lib.mkDefault true;
  };
}
