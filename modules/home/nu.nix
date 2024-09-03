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
           cd ~/nixos/; ${nixvim} .; sudo nixos-rebuild boot --flake ../#myConfig
        }

        def nixos-switch [] {
           cd ~/nixos/; ${nixvim} .; sudo nixos-rebuild switch --flake ../#myConfig
        }

	def nixos-rebuild-full [
	  command: string
	  --user (-u): string
	  --config (-c): string
	] {
	  cd ~/nixos/;
	  sudo nixos-rebuild $command --flake .#$user;
	  home-manager $command --flake .#$config
	}

        $env.config = {
     	show_banner: false,
        }
      '';
        envFile.text = ''
        $env.EDITOR = "${nixvim}";
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
