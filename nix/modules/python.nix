{ pkgs, ... }: {
  home.packages = with pkgs; [
    python312
    python312Packages.pip
    python312Packages.pipx
    poetry
    uv

    # Python development tools
    pipenv
    python3Packages.pip-tools
    black
    isort
    mypy
    python312Packages.flake8
    autoflake
    python312Packages.pytest
    python312Packages.ipython
    python312Packages.ipdb
    git-filter-repo

    # conda  # Uncomment if needed (not recommended with Nix)
    # pyenv
  ];

  # Link Python config files
  home.file = {
    ".config/pep8".source = ../../.config/python/pep8;
    ".config/pip/pip.conf".source = ../../.config/python/pip/pip.conf;
    ".config/matplotlib/matplotlibrc".source = ../../.config/python/matplotlib/matplotlibrc;
    ".config/pypoetry/config.toml".source = ../../.config/python/pypoetry/config.toml;
    ".condarc".source = ../../.config/python/conda/.condarc;
  };
}
