{ lib, ... }:

{
  options.userConfig = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "Unix username for this host.";
    };
    fullName = lib.mkOption {
      type = lib.types.str;
      description = "Full name used for git commits.";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "Email used for git commits.";
    };
    homeDirectory = lib.mkOption {
      type = lib.types.str;
      description = "Absolute home directory path.";
    };
  };
}
