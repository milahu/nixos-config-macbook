{ username }:

{ pkgs, lib, ... }:

let
  gnomeExtensionsPkgs = with pkgs.gnomeExtensions; [
    # nix eval --impure --json --expr 'with import <nixpkgs> {}; builtins.attrNames pkgs.gnomeExtensions'
    user-themes
    tray-icons-reloaded
    vitals
    dash-to-panel
    sound-output-device-chooser
    space-bar
  ];
in

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  # ...
  programs.home-manager.enable = true;
  home.stateVersion = "22.05";

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "palenight";

/*
most GNOME settings exist in dconf.
Run `dconf watch /`
and set whatever option you're looking
to declaratively persist, and observe the output.
*/

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = builtins.map (e: e.passthru.extensionUuid) gnomeExtensionsPkgs;
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "org.gnome.Terminal.desktop"
        "spotify.desktop"
        "virt-manager.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      workspace-names = [ "Main" ];
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-l.png";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-d.png";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-d.png";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };
  };

  home.packages = gnomeExtensionsPkgs ++ (with pkgs; [
    palenight-theme
  ]);

}
