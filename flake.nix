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
            imports = [
              ./modules/nixos/default.nix
            ];

            options.nyxed = (import ./config.nix lib).nyxedOptions;
            config = {
              nixpkgs.config.allowUnfree = true;
            };
          };
      };

    };
}
