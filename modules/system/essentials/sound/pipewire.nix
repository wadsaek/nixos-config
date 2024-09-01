{lib, config, ...}:
{
  services.pipewire = lib.mkIf (config.audio == "pipewire") { 
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
