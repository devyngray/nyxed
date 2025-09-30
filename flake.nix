{
  nixConfig = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
    {
      nixosModules.default =
        { config, pkgs, ... }:
        {
          imports = [
            ./modules/nixos/configuration.nix
          ];

          options.nyxed = {
            username = lib.mkOption {
              type = lib.types.str;
              default = "devyn";
              description = "Linux username, which will have a matching group created";
            };
            vcs_name = lib.mkOption {
              type = lib.types.str;
              default = "Devyn Gray";
              description = "Name used in jj config.toml for commits";
            };
            vcs_email = lib.mkOption {
              type = lib.types.str;
              default = "devyngray@proton.me";
              description = "Email used in jj config.toml for commits";
            };
          };

          config.nixpkgs.config.allowUnfree = true;
        };

      nixosConfigurations.test = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          self.nixosModules.default
        ];
      };

      homeManagerModules = {
        default =
          {
            config,
            lib,
            pkgs,
            ...
          }:
          {
            imports = [ ./modules/home-manager ];
            options.nyxed = (import ./config.nix lib).nyxedOptions;
          };
      };

      homeConfigurations."devyn" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };

        modules = [
          self.homeManagerModules.default
        ];
      };

    };
}
