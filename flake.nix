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
    in
    {
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
