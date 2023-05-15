/*
  based on
  https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/flake.nix
  https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/
*/

{
  description = "nixos config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # TODO use more?
    hardware.url = "github:nixos/nixos-hardware";

    # 16 colors scheme for terminal
    #nix-colors.url = "github:misterio77/nix-colors";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NUR
    nur.url = "github:nix-community/NUR";
    #nur.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {

    nixosModules = {
      #gnome = import ./modules/gnome.nix { inherit (nixpkgs) pkgs lib; };
      gnome = ./modules/gnome.nix;
      declarativeHome = { ... }: {
        config = {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        };
      };
      users-user = ./users/user;
    };

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # hostname
      macbook =
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          # > Our main nixos configuration file <
          modules = with self.nixosModules; [
            { config = { nix.registry.nixpkgs.flake = nixpkgs; }; }
            home-manager.nixosModules.home-manager
            gnome
            declarativeHome
            users-user
            # TODO split into modules
            ./configuration.nix #
          ];
        };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      /*
      # FIXME replace with your username@hostname
      "your-username@your-hostname" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [ ./home-manager/home.nix ];
      };
      */
    };
  };
}
