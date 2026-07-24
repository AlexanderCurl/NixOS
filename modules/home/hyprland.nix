{ config, pkgs, inputs, ... }:

{
  xdg.configFile."hypr" = {
    source = "${inputs.alexDotfiles}/hypr"; 
  };
}
