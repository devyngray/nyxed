{ config, lib, ... }:
let
  nyxed = config.nyxed;
in
{
  services = lib.mkIf nyxed.enableKDEPlasma {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };
}
