{ pkgs, nixos-hardware, ... }:
{
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  config = {
    hardware.framework.amd-7040.preventWakeOnAC = true;
    hardware.bluetooth.enable = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    services.logind.extraConfig = ''
      # don't shutfown when power button is short-pressed
      HandlePowerKey=ignore
    '';

    # locale
    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    # networking
    networking = {
      hostName = "blue";
      networkmanager.enable = true;
      nameservers = [
        "8.8.8.8"
        "1.1.1.1"
      ];
      firewall = {
        enable = true;
        allowedTCPPorts = [
          22
          80
          443
        ];
      };
    };
  };
}
