{pkgs, lib, config, ...}: {
  options= {
    home.nu.enable = lib.mkEnableOption "NuShell";
  };

  config = lib.mkIf config.home.nu.enable {
    programs.nushell =
      let 
        nixvim = "nix run github:wadsaek/nixvim";
      in{
      enable = true;
      configFile.text = ''
        def startssh [] {
        ^ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -r | into record | load-env
        }
        
        def nixos-boot [] {
           cd ~/nixos/nixos; ${nixvim} configuration.nix; sudo nixos-rebuild boot --flake ../#myConfig
        }

        def nixos-switch [] {
           cd ~/nixos/nixos; ${nixvim} configuration.nix; sudo nixos-rebuild switch --flake ../#myConfig
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
      shellAliases ={
        cat = "bat";
        nvim = nixvim;
        vi = nixvim;
        vim = nixvim;
        "nixvim" = nixvim;
        nvim-local = "${pkgs.neovim}/bin/nvim";
      };
    };
  };
}
