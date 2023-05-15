{ pkgs, lib, ... }:

{
  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    # remove packages
    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      #cheese # webcam tool
      gnome-music
      #gedit # text editor
      epiphany # web browser
      geary # email reader
      gnome-characters # ?
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      yelp # Help view
      gnome-contacts
      gnome-initial-setup
    ]);
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnome.gnome-disk-utility
    ];
    environment.variables = {
      # TODO better
      # integrate qt with gnome
      # https://discourse.nixos.org/t/how-to-fix-qt-themes-in-nixos/14495
      # https://wiki.archlinux.org/title/Uniform_look_for_Qt_and_GTK_applications
      "QT_STYLE_OVERRIDE" = lib.mkForce "kvantum";
    };
  };

}
