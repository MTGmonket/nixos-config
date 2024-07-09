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
  prepForStream = "showmethekey-gtk | pavucontrol | obs | firefox-devedition";
  cd = "z";
  cl = "clear;neofetch;";
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
    pavucontrol
    prismlauncher
    showmethekey
    smplayer
    wev
    wl-clipboard
    wl-clip-persist
    xdg-desktop-portal-hyprland
    xfce.thunar
    xorg.xrandr
  ];

  # program config
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2
      set shiftround
      set expandtab
      set autoindent
      set cpoptions+=I
      set smartindent
      set clipboard+=unnamedplus
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = indent-blankline-nvim-lua;
	config = '' lua require("ibl").setup() '';
      }
    ];
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
  programs.htop = {
    enable = true;
  };
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

	modules-center = [  ];
	modules-left = [ "hyprland/workspaces" ];
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
      preload = [ "~/.dotfiles/wallpaper/bliss1920x1080.png" ];
      wallpaper = [ ",~/.dotfiles/wallpaper/bliss1920x1080.png" ];
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ~/.dotfiles/hypr/hyprland.conf;
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {  };
  home.sessionVariables = {  };

  # home-manager version controls itself
  programs.home-manager.enable = true;
}
