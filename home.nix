{ config, pkgs, ... }:

# let
# bash binds
let myAliases = {
  ll = "ls -l";
  ".." = "cd ..";
  edconf = "nvim ~/.dotfiles/configuration.nix";
  edhome = "nvim ~/.dotfiles/home.nix";
  updateFlake = "cd ~/.dotfiles; nix flake update;";
  switchToFlake = "sudo nixos-rebuild switch --flake ~/.dotfiles/; home-manager switch --flake ~/.dotfiles/";
  switchToHome = "home-manager switch --flake ~/.dotfiles/";
}; in {
  home.username = "mtgmonkey";
  home.homeDirectory = "/home/mtgmonkey";
  # Don't change stateVersion
  home.stateVersion = "24.05";

  # packages
  home.packages = [
    pkgs.hello
  ];

  # program config
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };
  programs.git = {
    enable = true;
    userName = "MTGmonkey";
    userEmail = "MTGmonkey@emailprovider.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {  };
  home.sessionVariables = {  };

  # home-manager version controls itself
  programs.home-manager.enable = true;
}
