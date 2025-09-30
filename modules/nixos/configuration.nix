{ config, home-manager, ... }:
let
  nyxed = config.nyxed;
in
{
  imports = [ home-manager.nixosModules.home-manager ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    password = "changeme";
    group = "${nyxed.username}";
  };

  nix.settings.allowed-users = [ "${nyxed.username}" ];

  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm.enable = true;

    displayManager.sddm.wayland.enable = true;
  };

  system.stateVersion = "25.05";
}
