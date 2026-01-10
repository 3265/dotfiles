{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Go
    go
    ghq
    hugo

    # Docker (note: Docker daemon needs system-level setup)
    docker
    docker-compose
    lazydocker

    # Ruby
    rbenv
  ];

  # Link config files
  home.file = {
    ".gitconfig".source = ../.config/git/.gitconfig;
    ".agignore".source = ../.config/ag/.agignore;
    ".npmrc".source = ../.config/npm/.npmrc;
    ".gemrc".source = ../.config/gem/.gemrc;
    ".config/rstudio/rstudio-prefs.json".source = ../.config/rstudio/rstudio-prefs.json;
    ".gnupg/gpg-agent.conf".source = ../.config/gnupg/gpg-agent.conf;
  };
}
