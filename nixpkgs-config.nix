{
  allowUnfree = true;

  packageOverrides = pkgs: with pkgs; rec {

    st4nsonVim = pkgs.vim_configurable.override {
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
      name = "st4nson-env";
      paths = [

        cfssl
        chromium
        firefox
        go
        icedtea8_web
        libreoffice
        openconnect
        redshift
        remmina
        shutter
        slack
        st4nsonVim

        python27Packages.pylint
        python37Packages.pylint

        (python27.withPackages(ps: with ps; [
          cffi
          cryptography
          jinja2
          pyyaml
          requests
        ]))

        (python37.withPackages(ps: with ps; [
          jinja2
          pyyaml
          requests
        ]))
      ];
    };

  };
}
