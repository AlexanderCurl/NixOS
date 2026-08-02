{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    brave-origin
    discord
    slack
    kdePackages.kdeconnect-kde
    openrazer-daemon
    kitty-bin
    fastfetch
    mate-polkit
    polychromatic
    ffmpeg
    nextcloud-client
    ytmdesktop
    teams-for-linux
    teamspeak6-client
    prismlauncher
    easyeffects
    nwg-look
    nwg-displays
    pavucontrol
    hyprshot
    hyprwayland-scanner
    hyprland-qtutils
    hyprcursor
  ];
}
