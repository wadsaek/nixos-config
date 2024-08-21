{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wadsaek";
  home.homeDirectory = "/home/wadsaek";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wadsaek/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine";
    size = 16;
  };

  wayland.windowManager.hyprland= {
    enable = true;
    xwayland.enable = true;
    settings ={
      #apps for hyprland shortcuts
      "$terminal" = "kitty";
      "$fileManager" = "$terminal yazi";
      "$menu" = "rofi -show drun";
      "$screenshotCommand" = "grim";

      #autostart
      exec-once = "wpaperd & nm-applet & blueman-applet & waybar & $terminal --hold spotify_player & $terminal --hold fastfetch";

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];
      general = {
        gaps_in = 2;
        gaps_out = 10;
        
        border_size = 1;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = true;

        allow_tearing = true;

        layout = "dwindle";
      };

      decoration = {
        rounding = 3;
        active_opacity = 0.95;
        inactive_opacity = 0.7;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1,7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        #i probably want this?
        preserve_split = true;
      };
      master = {
        new_status="master";
      };
      misc = {
        force_default_wallpaper = -2;
        #DO NOT CHANGE
        disable_hyprland_logo = false;
      };
      input = {
        kb_layout = "us, ua, il";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle";
        kb_rules = "";
        
        follow_mouse = 1;
        
        sensitivity = 0; # no modification
        touchpad = {
          natural_scroll = true;
        };
      };
      gestures = {
        workspace_swipe = true;
      };
      
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod SHIFT, End, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod SHIFT, S, exec, $screenshotCommand"
        ",Print, exec, $screenshotCommand"
	      "$mainMod, L, exec, hyprlock"

        #dwindle
        "$mainMod, P, pseudo," #something weird idk i might need it sometimes... yk... like haskell
        "$mainMod, J, togglesplit,"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
         
        "$mainMod SHIFT, left, swapwindow, l" 
        "$mainMod SHIFT, right, swapwindow, r" 
        "$mainMod SHIFT, up, swapwindow, u"
        "$mainMod SHIFT, down, swapwindow, d"

        #the special workspace
        "$mainMod, M, togglespecialworkspace, magic"
        "$mainMod SHIFT, M, movetoworkspace, special:magic"

        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, mouse_down, workspace, e+1"
      ] 
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindel = [
      	", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      	", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
	", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
	", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
      bindl = [
	      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
	      ", XF86AudioPlay, exec, playerctl play-pause"
	      ", XF86AudioPrev, exec, playerctl previous"
	      ", XF86AudioNext, exec, playerctl next"
      ];
      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
    };
    extraConfig = 
    ''
      monitor = eDP-1,1920x1080@60,0x0,1
    '';
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blue_size = 8;
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          fade_on_empty = false;
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1800;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  
  programs.waybar = {
    enable = true;
    #settings = {};
    #style = "";
  };
  
  programs.git = {
    package = pkgs.gitFull;
    enable = true;
  };

  programs.nushell = {
    enable = true;
    configFile.text = ''
      def startssh [] {
      ^ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -r | into record | load-env
      }
      
      def nixos-boot [] {
         cd ~/nixos/nixos; nvim configuration.nix; sudo nixos-rebuild boot --flake ../#myConfig
      }

      def nixos-switch [] {
         cd ~/nixos/nixos; nvim configuration.nix; sudo nixos-rebuild switch --flake ../#myConfig
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
    };
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-pipewire-audio-capture
    ];
  };
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerdfonts;
      name = "Fira Code";
      size = 12;
    };
    settings = {
      foreground = "#d4d4d4";
      background = "#242020";

      editor = "nvim";
      notify_on_cmd_finish = "invisible 15.0";
    };
  };
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
	sort_dir_first = true;
      };
    };
  };
  programs.fastfetch = {
    enable = true;
    #settings = {
    #
    #}
  };
}
