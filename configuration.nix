{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system/steam.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # --- NIX SETTINGS & BINARY CACHES ---
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    
    # URLs of the binary caches
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    
    # Public keys required to verify the binaries
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

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
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # --- LOCALE & KEYBOARD ---
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure console keymap (for TTYs before the graphical environment loads)
  console.keyMap = "uk";

  # Configure the graphical keyboard layout (for X11 and Wayland/Hyprland)
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
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
    noto-fonts-color-emoji
  ];

  # --- SYSTEM SERVICES ---
  programs.gamemode.enable = true;
  services.flatpak.enable = true;
  
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # --- HYPRLAND ---
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true; 

  # --- CORE SYSTEM PACKAGES ---
  environment.systemPackages = with pkgs; [
    git
    neovim
    lm_sensors
    lsb-release
    linuxHeaders
    linux-firmware
    egl-wayland # EGL Wayland support for Nvidia
  ];

  users.users.alexc = {
    isNormalUser = true;
    description = "AlexC";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
  };

  system.stateVersion = "26.05";
}
