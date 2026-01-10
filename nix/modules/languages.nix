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

    # Commented out (uncomment if needed)
    # jdk8       # Conflicts with jdk
    # jdk11      # Conflicts with jdk
    # jdk17      # Conflicts with jdk
    fpc        # Pascal
    clisp      # LISP
    # ruby
    # go
    php        # PHP

    # rust
    rustup

    # Ruby
    rbenv
  ];

  # Link config files
  home.file = {
    ".npmrc".source = ../../.config/npm/.npmrc;
    ".gemrc".source = ../../.config/gem/.gemrc;
    ".config/rstudio/rstudio-prefs.json".source = ../../.config/rstudio/rstudio-prefs.json;
  };
}
