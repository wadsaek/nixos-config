{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    home.nu.enable = lib.mkEnableOption "NuShell";
  };

  config = lib.mkIf config.home.nu.enable {
    programs.nushell = {
      enable = true;
      configFile.text = ''
                def startssh [] {
                ^ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -r | into record | load-env
                }
                
                def nixvim [
        	  version: string
        	  ...args
        	] {
        	  nix run ("github:wadsaek/nixvim#" + $version) ...$args
        	}

                $env.config = {
             	show_banner: false,
                }
      '';
      envFile.text = ''
          $env.EDITOR = "nvim";
        	$env.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$env.HOME/.steam/root/compatibilitytools.d";
          $env.QT_QPA_PLATFORM = "wayland";
      '';
      shellAliases = {
        cat = "bat";
        vi = "nvim";
        vim = "nvim";
        nvim-local = "${pkgs.neovim}/bin/nvim";
      };
    };
  };
}
