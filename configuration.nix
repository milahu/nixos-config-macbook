# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

let
/*
FIXME
trace: warning: rustPlatform.rust.cargo is deprecated. Use cargo instead.
trace: warning: rustPlatform.rust.rustc is deprecated. Use rustc instead.
*/
  nixos-conf-editor = import (pkgs.fetchFromGitHub {
    owner = "vlinkz";
    repo = "nixos-conf-editor";
    rev = "0.1.1";
    sha256 = "sha256-TeDpfaIRoDg01FIP8JZIS7RsGok/Z24Y3Kf+PuKt6K4=";
  }) {};
in

{
  imports =
    [
      inputs.hardware.nixosModules.common-cpu-intel
      #inputs.hardware.nixosModules.common-ssd # not found
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # we have 4 cores
  # limit nix-build to 3 cores to avoid hanging the system
  nix.settings.cores = 3;
  nix.settings.max-jobs = 1;

  # https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/nixos/configuration.nix
  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  #nix.nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
/*
error: file 'nixpkgs' was not found in the Nix search path (add it using $NIX_PATH or -I)

       at /nix/store/d0ddxbyalkfbxdbnfa6xprl8g87n8zn1-source/default.nix:1:17:

            1| { pkgs ? import <nixpkgs> { }
             |                 ^
*/
  # https://discourse.nixos.org/t/problems-after-switching-to-flake-system/24093
  # https://discourse.nixos.org/t/correct-way-to-use-nixpkgs-in-nix-shell-on-flake-based-system-without-channels/19360
  nix.nixPath = [
    inputs.nixpkgs.outPath
    "nixpkgs=${inputs.nixpkgs.outPath}"
  ];
  # Enable flakes and new 'nix' command
  nix.settings.experimental-features = "nix-command flakes";
  # Deduplicate and optimize nix store
  nix.settings.auto-optimise-store = true;
  # TODO automate garbage collect

  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  nixpkgs.overlays = [
    inputs.nur.overlay
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.timeout = 2; # default: 5 seconds

  # Enable NTFS support
  boot.supportedFilesystems = [
    "ntfs" # microsoft windows
    "apfs" # apple macos
  ];

  boot = {
    tmp.cleanOnBoot = true;
    #kernelPackages = pkgs.linuxPackages_4_3;
    kernelParams = [
      # https://help.ubuntu.com/community/AppleKeyboard
      # https://wiki.archlinux.org/index.php/Apple_Keyboard
      # fnmode:
      # 0 = disabled: Disable the 'fn' key.
      #     Pressing 'fn'+'F8' will behave like you only press 'F8'
      # 1 = fkeyslast: Function keys are used as last key.
      #     Pressing 'F8' key will act as a special key. Pressing 'fn'+'F8' will behave like a F8.
      # 2 = fkeysfirst: Function keys are used as first key.
      #     Pressing 'F8' key will behave like a F8.
      #     Pressing 'fn'+'F8' will act as special key (play/pause). 
      # 3 = auto (default)
      #"hid_apple.fnmode=1"
      #"hid_apple.fnmode=2"
      # fix swapped keys and wrong keymaps for international (non-US) keyboards
      #"hid_apple.iso_layout=0"
      # swap cmd and Alt keys (PC layout)
      #"hid_apple.swap_opt_cmd=1"
      # Swap the Fn and L_Control keys (PC layout)
      #"swap_fn_leftctrl=1"
    ];
  };

  # fix: grub error: switching console mode: unsupported
  # https://communities.vmware.com/t5/Fusion-22H2-Tech-Preview/On-boot-quot-error-switching-console-mode-to-1-unsupported-quot/m-p/2895906
  # https://github.com/NixOS/nixpkgs/issues/210070
  # default: "keep"
  boot.loader.systemd-boot.consoleMode = "0"; # Standard UEFI 80x25 mode

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

  # power management
  # hibernate on empty battery, to avoid discharging battery to zero,
  # which would destroy the battery.
  # https://discourse.nixos.org/t/config-to-hibernate-when-battery-is-critically-low/2451/5
  services.upower.criticalPowerAction = "Hibernate";

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
    ];
  };

  # allow to install packages from flathub (for Gnome, etc)
  # https://nixos.wiki/wiki/Flatpak
  services.flatpak.enable = true;

  # https://nixos.wiki/wiki/Fonts
  /*
    ln -s /run/current-system/sw/share/X11/fonts ~/.local/share/fonts
    flatpak --user override --filesystem=$HOME/.local/share/fonts
    flatpak --user override --filesystem=$HOME/.icons
  */
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  # TODO hidpi?
  # use this instead of hardware.video.hidpi.enable
  #fonts.fontconfig = TODO;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "user";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nix-index
    wget
    vim
    git
    htop
    smartmontools # smartctl
    # https://www.linuxjournal.com/content/how-you-can-change-cursor-theme-your-ubuntu-desktop
    gnome.gnome-tweaks
    firefox
    qbittorrent
    gimp
    inkscape
    #libreoffice-bin
    abiword

    # markdown
    ghostwriter

    mixxx # DJ music player

    gparted # partition editor
    xclip # clipboard access
    unzip
    unrar
    p7zip
    python3
    nodejs
    #pandoc
    ffmpeg
    vscode-with-extensions
    # fixme build fails
    nixos-conf-editor
    #nur.repos.mic92.hello-nur
    #nur.repos.milahu.spotify-adblock # FIXME

    libsForQt5.qtstyleplugin-kvantum

  ];

  environment.variables = {
    # integrate qt with gnome
    # https://discourse.nixos.org/t/how-to-fix-qt-themes-in-nixos/14495
    "QT_STYLE_OVERRIDE" = lib.mkForce "kvantum";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    #enable = true;
    # Forbid root login through SSH.
    settings.PermitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    settings.PasswordAuthentication = false;
  };

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
