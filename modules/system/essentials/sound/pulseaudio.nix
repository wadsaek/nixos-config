{lib,config, ...}:{
  hardware.pulseaudio.enable = lib.mkIf (config.audio == "pulseaudio") true;
}
