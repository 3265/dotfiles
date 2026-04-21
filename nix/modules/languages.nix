{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Go
    go

    # Utilities
    jq

    # Languages
    nodejs

    # Java (default version only)
    jdk  # Latest JDK
    maven
    google-java-format

    # C++ tools
    vcpkg

    # Math
    gap  # GAP System for Computational Discrete Algebra

    fpc        # Pascal
    clisp      # LISP
    php        # PHP

    # rust
    rustup

    # Ruby
    rbenv
  ];

  # Link config files
  home.file = {
    ".npmrc".source = ../../config/npm/.npmrc;
    ".gemrc".source = ../../config/gem/.gemrc;
    ".config/rstudio/rstudio-prefs.json".source = ../../config/rstudio/rstudio-prefs.json;
  };
}
