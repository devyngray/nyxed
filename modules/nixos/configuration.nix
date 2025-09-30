{ config, ... }:
let
  cfg = config.nyxed;
in
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";

  users.groups.${cfg.username} = { };
  users.users.${cfg.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "changeme";
    group = "${cfg.username}";
  };

  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm.enable = true;

    displayManager.sddm.wayland.enable = true;
  };
}
