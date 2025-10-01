{ ... }:
{
  imports = [
    ./boot.nix
    ./desktop.nix
    ./home.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.05";
}
