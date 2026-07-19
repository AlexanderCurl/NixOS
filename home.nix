{ config, pkgs, ... }:

{
  imports = [
    ./modules/home/hyprland.nix
    ./modules/home/brave.nix
    ./modules/home/discord.nix
    ./modules/home/slack.nix
  ];

  home.username = "alexc";
  home.homeDirectory = "/home/alexc";

  # --- USER PACKAGES ---
  home.packages = with pkgs; [
    kitty
    bitwarden
    easyeffects
    pavucontrol
    nwg-look
    nwg-displays
    kwalletmanager
    libsForQt5.kwallet-pam
    libsForQt5.qtstyleplugin-kvantum
    prism-launcher
    jdk22 # Fallback/standard if jdk25 specifically is named diff in nixpkgs tree
    hyprshot
    hyprpicker
    hyprcursor
    hyprwayland-scanner
    filezilla
    dolphin
    
    # Catch-all for less common/custom requests (assuming they're packaged in latest nixpkgs)
    # opendeck hyprland-guiutils hyprgraphics hyprwire
  ];

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
