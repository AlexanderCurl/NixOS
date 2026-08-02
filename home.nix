{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dankMaterialShell.default
    inputs.alexDotfiles.homeManagerModules.default

    ./modules/home/packages.nix
  ];

  programs.dankMaterialShell.enable = true;
  home.username = "alexc";
  home.homeDirectory = "/home/alexc";

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
