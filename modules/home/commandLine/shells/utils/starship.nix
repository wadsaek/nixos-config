{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    home.starship.enable = lib.mkEnableOption "starship";
  };

  config = lib.mkIf config.home.starship.enable {
    programs.starship = {
      enable = true;
      enableNushellIntegration = lib.mkIf config.home.nu.enable (lib.mkDefault true);
      enableZshIntegration = lib.mkIf config.home.zsh.enable (lib.mkDefault true);

      settings = {
        format = "$username$hostname$localip$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$fossil_metrics$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$pijul_channel$shell$all";
        shell = {
          style = "green bold";
          format = "via [$indicator]($style) ";
          disabled = false;
        };
      };

    };
  };
}
