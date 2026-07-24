{ config, pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true; # Enable XWayland support
  };

  xdg.configFile."hypr" = {
    source = "${inputs.alexDotfiles}/hypr"; 
  };
}
