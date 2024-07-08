{ config, pkgs, lib, ... }:

# let
# bash binds
let 
myAliases = {
  ll = "ls -l";
  ".." = "cd ..";
  edconf = "nvim ~/.dotfiles/configuration.nix";
  edhome = "nvim ~/.dotfiles/home.nix";
  updateFlake = "cd ~/.dotfiles; nix flake update;";
  switchToFlake = "home-manager switch --flake ~/.dotfiles/";
  ffd = "firefox-devedition";
  prepForStream = "showmethekeys-gtk | pavucontrol | obs | firefox-devedition";
};
termrc = ''
  function pushFlake { cd ~/.dotfiles; git add *; git commit -m $1; git push github main; };
'';
in {
  home.username = "mtgmonkey";
  home.homeDirectory = "/home/mtgmonkey";
  # Don't change stateVersion
  home.stateVersion = "24.05";

  # packages
  home.packages = with pkgs; [
    firefox-devedition
    git
    hello
    lxqt.lxqt-policykit
    mplayer
    neofetch
    neovim
    pavucontrol
    prismlauncher
    showmethekey
    smplayer
    wev
    xdg-desktop-portal-hyprland
    xfce.thunar
    xorg.xrandr
  ];

  # program config
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    initExtra = termrc;
  };
  programs.bash = {
    enable = false;
    shellAliases = myAliases;
    bashrcExtra = termrc;
  };
  programs.alacritty = {
    enable = true;
    settings = {
      
    };
  };
  programs.git = {
    enable = true;
    userName = "MTGmonkey";
    userEmail = "MTGmonkey@emailprovider.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  programs.obs-studio = {
    enable = true;
  };
  programs.waybar = {
    enable = true;
    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
      window#waybar {
        background : transparent;
        border-bottom : none;
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
	position = "top";
        height = 30;
	spacing = 6;

	modules-left = [  ];
	modules-center = [ "hyprland/workspaces" ];
	modules-right = [ "battery" "pulseaudio" "clock" ];

	battery = {
	  format = "{icon}";
	  format-icons = [ "0000" "0001" "0010" "0011" "0100" "0101" "0110" "0111" "1000" "1001" "1010" "1011" "1100" "1101" "1110" "1111" ];
	};
	clock = {
	  format = "{:%H:%M:%S}";
	};
	pulseaudio = {
	  format = "{icon}";
	  format-icons = [ "0000" "0001" "0010" "0011" "0100" "0101" "0110" "0111" "1000" "1001" "1010" "1011" "1100" "1101" "1110" "1111" ];
	  on-click = "pavucontrol";
        };
      };
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      irc = "off";
      splash = false;
      preload = [ "~/.dotfiles/wallpaper/hero1920x1080.png" ];
      wallpaper = [ ",~/.dotfiles/wallpaper/hero1920x1080.png" ];
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [  ];
    settings = {  };
    extraConfig = 
     "monitor=,highres,auto,1

      # programs
      $terminal = alacritty
      $fileManager = thunar
      $bar = waybar
      $wallpaper = hyprpaper

      # autostart
      exec-once = $bar
      exec-once = lxqt-policykit-agent
      exec-once = $terminal
      exec-once = $wallpaper

      # environment vars
      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24

      # visuals
      general {
        gaps_in = 6
	gaps_out = 6
	border_size = 1

	resize_on_border = true
	
	# dwindle : tree; master : obvi;
	layout = master
      }

      decoration {
        rounding = 0

	active_opacity = 0.66
	inactive_opacity = 0.20

	drop_shadow = false

	blur {
	  enabled = false
	  new_optimizations = on
	}
      }

      animations {
        enabled = true;
	bezier = myBezier, 0.6, 0.14, 0, 1

	animation = windows, 1, 6, myBezier
	animation = windowsOut, 1, 6, default, popin 80%
	animation = border, 1, 8, default
	animation = fade, 1, 6, default
	animation = workspaces, 1, 6, default
      }
      
      dwindle {
        pseudotile = true
	preserve_split = false
      }

      master {
        new_status = master
      }

      misc {
        force_default_wallpaper = -1
	disable_hyprland_logo = false
      }
      
      input {
        kb_layout = us
	kb_variant = 
	kb_model = 
	kb_options = 
	kb_rules = 

	follow_mouse = 1
	sensitivity = 0.1 # -1.0 to 1.0

	touchpad {
	  natural_scroll = false
	}
      }

      gestures {
        workspace_swipe = false
      }
      
      # binds
      $m0 = SUPER

      bind = $m0, T, exec, $terminal
      bind = $m0, F, exec, $fileManager
      bind = $m0, C, killactive,
      bind = $m0, Q, exit,

      bind = $m0, left, movefocus, l
      bind = $m0, right, movefocus, r
      bind = $m0, up, movefocus, u
      bind = $m0, down, movefocus, d

      bind = $m0, 1, workspace, 1
      bind = $m0, 2, workspace, 2
      bind = $m0, 3, workspace, 3
      bind = $m0, 4, workspace, 4
      bind = $m0, 5, workspace, 5
      bind = $m0, 6, workspace, 6
      bind = $m0, 7, workspace, 7
      bind = $m0, 8, workspace, 8
      bind = $m0, 9, workspace, 9
      bind = $m0, 0, workspace, 10      

      bind = $m0 SHIFT, 1, movetoworkspace, 1
      bind = $m0 SHIFT, 2, movetoworkspace, 2
      bind = $m0 SHIFT, 3, movetoworkspace, 3
      bind = $m0 SHIFT, 4, movetoworkspace, 4
      bind = $m0 SHIFT, 5, movetoworkspace, 5
      bind = $m0 SHIFT, 6, movetoworkspace, 6
      bind = $m0 SHIFT, 7, movetoworkspace, 7
      bind = $m0 SHIFT, 8, movetoworkspace, 8
      bind = $m0 SHIFT, 9, movetoworkspace, 9
      bind = $m0 SHIFT, 0, movetoworkspace, 10  

      bind = $m0, S, layoutmsg, swapwithmaster

      $stk = (Floating Window - Show Me The Key)
      windowrule = float, title:$stk
      windowrule = pin, title:$stk
      windowrule = nofocus, title:$stk
      windowrule = opaque, title:$stk
      windowrule = noblur, title:$stk
      windowrule = move 0 -49, title:$stk
      windowrule = size 90% 80, title:$stk

      ";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {  };
  home.sessionVariables = {  };

  # home-manager version controls itself
  programs.home-manager.enable = true;
}
