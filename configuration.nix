# configuration.nix
# bare minimum

{ config, lib, ... }:
{ imports = [ ./hardware-configuration.nix ];

  # packages / programs / services
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [  ];

  # package overlays / config
  nixpkgs = {
    overlays = [  ];
    config = { allowUnfree = true; };
  };

  # network
  networking.hostName = "dell-latitude";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  
  # users
  users.users = {
    mtgmonkey = {
      isNormalUser = true;
      description = "MTGmonkey";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  # sound
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = false;
  };

  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # desktop
  programs.hyprland.enable = true;
  services.printing.enable = true;
  services.libinput.enable = true;

  # meta
  services.automatic-timezoned.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "24.05";
}
