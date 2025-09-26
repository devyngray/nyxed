lib: {
  nyxedOptions = {
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "Hostname";
    };
    username = lib.mkOption {
      type = lib.types.str;
      default = "devyn";
      description = "Username";
    };
    vcs_name = lib.mkOption {
      type = lib.types.str;
      default = "Devyn Gray";
      description = "Name used in jj config.toml for commits";
    };
    vcs_email = lib.mkOption {
      type = lib.types.str;
      default = "devyngray@proton.me";
      description = "Email used in jj config.toml for commits";
    };
  };
}
