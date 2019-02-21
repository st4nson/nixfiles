{
  allowUnfree = true;

  packageOverrides = pkgs: with pkgs; rec {

    customVim = pkgs.vim_configurable.override {
      features = "huge"; # one of  tiny, small, normal, big or huge
      gui = "gtk";
      cfg = {
        luaSupport = true;
        rubySupport = true;
        cscopeSupport = true;
        pythonSupport = true;
        python3Support = true;
        multibyteSupport = true;
      };
      flags = {
        xim.enable = true;
      };
    };

    myPackages = pkgs.buildEnv {
      name = "myEnv";
      paths = [
        customVim
        (python27.withPackages(ps: with ps; [
          cffi
          cryptography
          jinja2
          pyyaml
          requests
        ]))
        (python36.withPackages(ps: with ps; [
          jinja2
          pyyaml
          requests
        ]))
      ];
    };

  };
}
