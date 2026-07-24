{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dankMaterialShell.default

    ./modules/home/hyprland.nix
    ./modules/home/brave.nix
    ./modules/home/discord.nix
    ./modules/home/slack.nix
  ];


  programs.dankMaterialShell.enable = true;
  home.username = "alexc";
  home.homeDirectory = "/home/alexc";

  # --- USER PACKAGES ---
  home.packages = with pkgs; [
    kitty
    easyeffects
    pavucontrol
    nwg-look
    nwg-displays
    libsForQt5.kwallet-pam
    libsForQt5.qtstyleplugin-kvantum
    hyprshot
    hyprpicker
    hyprcursor
    hyprwayland-scanner
    
    # Catch-all for less common/custom requests (assuming they're packaged in latest nixpkgs)
    # opendeck hyprland-guiutils hyprgraphics hyprwire
  ];

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
