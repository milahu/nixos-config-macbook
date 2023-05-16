# List packages installed in system profile. To search, run:
# $ nix search wget

#  environment.systemPackages =

{ pkgs, ... }:

let
  /*
    FIXME
    trace: warning: rustPlatform.rust.cargo is deprecated. Use cargo instead.
    trace: warning: rustPlatform.rust.rustc is deprecated. Use rustc instead.
  */
  nixos-conf-editor = import
    (pkgs.fetchFromGitHub {
      owner = "vlinkz";
      repo = "nixos-conf-editor";
      rev = "0.1.1";
      sha256 = "sha256-TeDpfaIRoDg01FIP8JZIS7RsGok/Z24Y3Kf+PuKt6K4=";
    })
    { };

  nix-software-center = import (pkgs.fetchFromGitHub {
    owner = "vlinkz";
    repo = "nix-software-center";
    rev = "0.1.2";
    sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
  }) {};

in

with pkgs; [
  nix-index # find nix packages by content
  nixpkgs-fmt # code formatter for nix files
  wget
  vim
  git
  htop
  smartmontools # smartctl
  # https://www.linuxjournal.com/content/how-you-can-change-cursor-theme-your-ubuntu-desktop
  firefox
  qbittorrent
  gimp
  inkscape
  #libreoffice-bin
  abiword

  # markdown
  #marktext # no dark theme
  ghostwriter

  mixxx # DJ music player

  mpv # video player

  gparted # partition editor
  xclip # clipboard access
  unzip
  unrar
  p7zip
  python3
  nodejs
  jq # json query
  #pandoc
  ffmpeg
  #vscode-with-extensions
  vscode

  # snowflakeOS apps
  # https://discourse.nixos.org/t/snowflakeos-creating-a-gui-focused-nixos-based-distro/21856
  # https://snowflakeos.org/

  nixos-conf-editor
  nix-software-center

  #nur.repos.mic92.hello-nur
  #nur.repos.milahu.spotify-adblock # FIXME

  # TODO better
  libsForQt5.qtstyleplugin-kvantum

  imagemagick
  libjpeg # jpegtran
  screen
  yt-dlp # youtube downloader

  nmap

  # FIXME font scaling in "small picture" mode
  # GDK_SCALE=2 steam
  # it works in "big picture" mode (fullscreen)
  steam # games

  darling-dmg # run macos apps on linux

  # wine: run windows programs on linux
  # support both 32- and 64-bit applications
  #wineWowPackages.stable

  # support 32-bit only
  #wine

  # support 64-bit only
  #(wine.override { wineBuild = "wine64"; })

  # wine-staging (version with experimental features)
  wineWowPackages.staging

  # winetricks (all versions)
  winetricks

  # SSH without port-forwarding
  # https://superuser.com/a/1506237
  #ngrok # moved to services.ngrok

  # https://stackoverflow.com/questions/286419/how-to-build-a-dmg-mac-os-x-file-on-a-non-mac-platform
  hfsprogs # mkfs.hfsplus # apple filesystem
  cdrkit # genisoimage # generate dmg image files

  gnome.polari # IRC chat
  element-desktop # matrix chat
  tdesktop # telegram chat
  whatsapp-for-linux # facebook chat
  discord

  gnome.geary # email
]
