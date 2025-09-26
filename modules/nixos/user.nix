{ inputs, config, ... }:
let
  cfg = config.nyxed;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs config; };
    users.${cfg.username} = {
      imports = [ ../home-manager ];
    };
  };

  users.users."${cfg.username}" = {
    isNormalUser = true;
    description = "${cfg.username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nix.settings.allows-users = [ "${cfg.username}" ];
}
