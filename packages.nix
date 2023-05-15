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
  ghostwriter

  mixxx # DJ music player

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
  vscode-with-extensions
  #nixos-conf-editor
  #nur.repos.mic92.hello-nur
  #nur.repos.milahu.spotify-adblock # FIXME

  # TODO better
  libsForQt5.qtstyleplugin-kvantum

  imagemagick
  libjpeg # jpegtran
  screen
  yt-dlp # youtube downloader

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
]
