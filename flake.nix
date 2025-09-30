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
        specialArgs = { inherit home-manager; };
        modules = [
          self.nixosModules.default
          {
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
}
