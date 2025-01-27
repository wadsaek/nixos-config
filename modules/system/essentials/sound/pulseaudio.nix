{ lib, config, ... }:
{
  services.pulseaudio.enable = config.audio == "pulseaudio";
}
