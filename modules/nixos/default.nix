{ ... }:
{
  imports = [
    ./boot.nix
    ./desktop.nix
    ./home.nix
    ./system.nix
  ];

  system.stateVersion = "25.05";
}
