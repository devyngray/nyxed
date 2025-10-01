{ config, home-manager, ... }:
let
  nyxed = config.nyxed;
in
{
  imports = [ home-manager.nixosModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit nyxed;
    };
    users.${nyxed.username} = {
      imports = [ ../home-manager ];
      home.username = "${nyxed.username}";
      home.homeDirectory = "/home/${nyxed.username}";
      home.stateVersion = "25.05";
      programs.home-manager.enable = true;
    };
  };

  users.groups.${nyxed.username} = { };
  users.users.${nyxed.username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    initialPassword = "changeme";
    group = "${nyxed.username}";
  };

  nix.settings.allowed-users = [ "${nyxed.username}" ];
}
