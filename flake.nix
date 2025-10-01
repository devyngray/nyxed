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
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosModules.default =
        {
          config,
          pkgs,
          lib,
          ...
        }:
        {
          imports = [
            ./modules/nixos
          ];

          options.nyxed = {
            enableKDEPlasma = lib.mkEnableOption "Use KDE plasma desktop environment";
            username = lib.mkOption {
              type = lib.types.str;
              default = "devyn";
              description = "Linux username, which will have a matching group created";
            };
            vcsName = lib.mkOption {
              type = lib.types.str;
              default = "Devyn Gray";
              description = "Name used in jj config.toml for commits";
            };
            vcsEmail = lib.mkOption {
              type = lib.types.str;
              default = "devyngray@proton.me";
              description = "Email used in jj config.toml for commits";
            };
          };

          config.nixpkgs.config.allowUnfree = true;
        };

      nixosConfigurations = {
        blue = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit home-manager nixos-hardware; };
          modules = [
            self.nixosModules.default
            ./hosts/blue
            {
              nyxed.enableKDEPlasma = true;

              virtualisation.vmVariant = {
                virtualisation = {
                  memorySize = 4096;
                  cores = 4;
                  graphics = true;
                };
              };
            }
          ];
        };
      };
    };
}
