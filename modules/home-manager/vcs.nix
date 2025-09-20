{ config, pkgs, ... }:
let
  cfg = config.nyxed;
in
{
  # install git
  home.packages = [
    pkgs.git
  ];

  # enable jj
  programs.jujutsu = {
    enable = true;
  };

  # configure jj
  programs.jujutsu.settings = {
    user = {
      name = cfg.vcs_name;
      email = cfg.vcs_email;
    };

    ui = {
      default-command = "shortlog";
      diff-formatter = "git";
    };

    revset-aliases = {
      "closest_bookmark(to)" = "heads(::to & bookmarks())";
      "unmerged(from)" = "::from ~ ::trunk()";
    };

    aliases = {
      shortlog = [
        "log"
        "-n"
        "20"
      ];
      a = [
        "log"
        "-r"
        "all()"
      ];
      b = [ "bookmark" ];
    };

    code.fsmonitor = "watchman";
  };
}
