# Place your /etc/nixos/hardware-configuration.nix here
{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
}
