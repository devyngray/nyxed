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
            ./modules/nixos/configuration.nix
          ];

          options.nyxed = (import ./config.nix lib).nyxedOptions;
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
