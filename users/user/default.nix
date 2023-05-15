{ pkgs, lib, ... }:

let
  username = "user";
in

{
  config = {
    home-manager.users.${username} = import ./home.nix { inherit username; };
    /*
      home-manager.users.${username} = import ./home.nix {
      inherit username;
      };
    */
    users.users.${username} = {
      isNormalUser = true;
      description = "user";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        # ...
      ];
    };
  };
}
