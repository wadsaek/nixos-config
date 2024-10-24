{ lib, config, ... }:
{
  options.mangohud.enable = lib.mkEnableOption "mangohud";

  config.programs.mangohud = lib.mkIf config.mangohud.enable {
    enable = true;
    enableSessionWide = true;
    settings = {
      fps_limit = "60,30";
      toggle_fps_limit = "F1";

      legacy_layout = false;
      gpu_temp = true;
      gpu_text = "GPU";
      cpu_temp = true;
      cpu_text = "CPU";
      fps = true;
      frame_timing = 0;
      background_alpha = lib.mkForce 0;
      font_size = lib.mkForce 24;

      position = "top-center";
      round_corners = 10;
      toggle_hud = "Shift_R+F12";
      toggle_logging = "Shift_L+F2";
      upload_log = "F5";
      output_folder = /home/wadsaek;
      media_player_name = "spotify";
    };
  };
}
