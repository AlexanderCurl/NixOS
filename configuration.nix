{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system/steam.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "sasuke";
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  # --- HARDWARE & KERNEL ---
  hardware.enableRedistributableFirmware = true;
  
  # --- GRAPHICS & NVIDIA ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # 32-bit support for games/Steam/Mesa
  };
  
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
  };

  # --- PIPEWIRE & AUDIO ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # 32-bit audio support
    pulse.enable = true;
    jack.enable = true;
  };

  # --- SECURITY & POLKIT ---
  security.polkit.enable = true;
  security.pam.services.sddm.enableKwallet = true; # KWallet PAM integration

  # --- PORTALS ---
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  };

  # --- FONTS ---
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  # --- SYSTEM SERVICES ---
  programs.dms.enable = true;
  programs.gamemode.enable = true;
  services.flatpak.enable = true;
  
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true; 

  # --- CORE SYSTEM PACKAGES ---
  environment.systemPackages = with pkgs; [
    git
    neovim
    mate.mate-polkit # Required by DMS
    lm_sensors
    lsb-release
    linuxHeaders
    linux-firmware
    egl-wayland # EGL Wayland support for Nvidia
    ffmpeg
    fastfetch
    gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];

  users.users.alexc = {
    isNormalUser = true;
    description = "Alex C";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
  };

  system.stateVersion = "26.05";
}
