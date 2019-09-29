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

    pidgin-with-plugins = pkgs.pidgin-with-plugins.override {
      plugins = [ pkgs.pidgin-sipe ];
    };

    myPackages = pkgs.buildEnv {
      name = "st4nson-env";
      paths = [

        ansible-lint
        ansible_2_7
        cfssl
        gopass
        openconnect
        redshift
        st4nsonVim
        taskwarrior

        chromium
        firefox
        icedtea8_web
        keepassxc
        libreoffice
        pidgin-with-plugins
        remmina
        shutter
        slack

        ctags
        go_1_12
        shellcheck

        docker-compose
        docker-ls
        docker-machine

        kubectx
        qemu
        virtmanager

        python27Packages.flake8
        python27Packages.pep8
        python27Packages.pylint
        python37Packages.flake8
        python37Packages.pep8
        python37Packages.pylint

        (python27.withPackages(ps: with ps; [
          cffi
          cryptography
          isort
          jedi
          jinja2
          pyopenssl
          pytest
          pyyaml
          requests
          tox
        ]))

        (python37.withPackages(ps: with ps; [
          isort
          jedi
          jinja2
          pylint
          pyopenssl
          pytest
          pyyaml
          requests
          tox
        ]))
      ];
    };

  };
}
