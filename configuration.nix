# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  nixos-conf-editor = import (pkgs.fetchFromGitHub {
    owner = "vlinkz";
    repo = "nixos-conf-editor";
    rev = "0.1.1";
    sha256 = "sha256-TeDpfaIRoDg01FIP8JZIS7RsGok/Z24Y3Kf+PuKt6K4=";
  }) {};
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # we have only 2 cores
  # limit nix-build to 1 core to avoid hanging the system
  nix.settings.cores = 1;
  nix.settings.max-jobs = 1;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "macbook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  /*
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  */

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Gnome
  services.xserver.displayManager.gdm.enable = true;

  # Pantheon
  # pretty desktop, but not as mature as KDE or Gnome
  # scrolling is inverted, different for touchpad and mouse
  # warning: Using Pantheon without LightDM as a displayManager will break screenlocking from the UI.
  #services.xserver.displayManager.lightdm.enable = true;

  # KDE
  #services.xserver.displayManager.sddm.enable = true;

  # Pantheon
  #services.xserver.desktopManager.pantheon.enable = true;

  # KDE
  #services.xserver.desktopManager.plasma5.enable = true;

  # Gnome
  services.xserver.desktopManager.gnome.enable = true;

  # Xfce
  # fixme: no network
  #services.xserver.desktopManager.xfce.enable = true;
  # Xfce: fix small cursor on hidpi display
  # https://github.com/NixOS/nixpkgs/issues/21442
  #environment.variables.XCURSOR_PATH = "$HOME/.icons";
  #environment.profileRelativeEnvVars.XCURSOR_PATH = [ "/share/icons" ];
  #environment.sessionVariables.GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";

  # solve conflict between pantheon and plasma5
  #services.xserver.displayManager.defaultSession = "plasma";

  # solve conflict between pantheon and gnome
  #environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = "/nix/store/mcfmxj7jmjz1m4dclrn4ln9xksbicikh-elementary-gsettings-desktop-schemas/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";
  #environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = "/nix/store/1dsy3g5rn7qp9p74k5j80s6ryaq1jd83-gnome-gsettings-overrides/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";

  # solve conflict between gnome and plasma5
  #programs.ssh.askPassword = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "mac";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
      # fixme build fails
      #nixos-conf-editor
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "user";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    htop
    smartmontools # smartctl
    gnome.gnome-tweaks
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
