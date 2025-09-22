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
    { ... }:
    {
      nixosModules = {
        default =
          {
            config,
            lib,
            pkgs,
            ...
          }:
          {
            # TODO: add modules/nixos/default.nix import
            #
            options.nyxed = (import ./config.nix lib).nyxedOptions;

            config = {
              nixpkgs.config.allowUnfree = true;
            };
          };
      };

      homeManagerModules = {
        default =
          {
            config,
            lib,
            pkgs,
            osConfig ? { },
            ...
          }:
          {
            imports = [ ./modules/home-manager ];

            options.nyxed = (import ./config.nix lib).nyxedOptions;
            config = lib.mkIf (builtins.hasAttr osConfig "nyxed") {
              nyxed = osConfig.nyxed;
            };
          };
      };
    };
}
