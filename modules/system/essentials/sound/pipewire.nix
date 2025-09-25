{
  lib,
  config,
  pkgs,
  ...
}:
{
  services.pipewire = lib.mkIf (config.audio == "pipewire") {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  environment.systemPackages = lib.optional (config.audio == "pipewire") pkgs.qpwgraph;

}
