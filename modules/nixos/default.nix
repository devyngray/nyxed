{ ... }:
{
  imports = [
    ./boot.nix
    ./desktop.nix
    ./home.nix
  ];

  system.stateVersion = "25.05";
}
