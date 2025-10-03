{ lib, nyxed, ... }:
{
  programs.plasma = lib.mkIf nyxed.desktop {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
    };

    input.keyboard = {
      options = [ "caps:escape" ];
    };
  };
}
