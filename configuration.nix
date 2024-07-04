# configuration.nix
# bare minimum

{ inputs, lib, config, pkgs, ... }:
{ imports = [ ./hardware-configuration.nix ];

  # packages / programs / services
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    firefox-devedition
    git
    lf
    neofetch
    neovim
    wget
  ];

  # package overlays / config
  nixpkgs = {
    # add overlays here
    overlays = [  ];
    config = { allowUnfree = true; };
  };

  # network
  networking.hostName = "dell-latitude";
  networking.networkmanager.enable = true;
  
  # users
  users.users = {
    mtgmonkey = {
      isNormalUser = true;
      description = "MTGmonkey";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # desktop
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.printing.enable = true;
  services.libinput.enable = true;
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  }; 

  # meta
  services.automatic-timezoned.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "24.05";
}
