{ lib, config, ... }:
{
  options.mangohud.enable = lib.mkEnableOption "mangohud";

  config.programs.mangohud = lib.mkIf config.mangohud.enable {
    enable = true;
    settings = {
      legacy_layout = false;
      fps_limit = "144,60,30";
      background_alpha = lib.mkForce 0.0;
      round_corners = 10;

      font_size = lib.mkForce 18;
      position = "top-center";
      toggle_hud = "Shift_R+F12";
      pci_dev = "0:65:00.0";
      table_columns = 3;
      gpu_text = "GPU";
      gpu_stats = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      cpu_text = "CPU";
      cpu_stats = true;
      cpu_mhz = true;
      fps = true;
      fps_limit_method = "late";
      toggle_fps_limit = "Shift_L+F1";
      output_folder = "/home/wadsaek";
      log_duration = 30;
      autostart_log = 0;
      log_interval = 100;
      toggle_logging = "Shift_L+F2";
    };
  };
}
