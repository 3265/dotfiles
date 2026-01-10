{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Build tools
    gcc
    gnumake
    cmake

    # Basic utilities
    util-linux
    fish
    silver-searcher
    tree
    fzf
    bat
    xsel
    xclip
    autojump
    direnv
    zip
    unzip
    nettools
    cmatrix
    apacheHttpd
    whois
    curl
    inxi
    htop
    lsd
    fastmod
    ghq

    # Docker (note: Docker daemon needs system-level setup)
    # docker
    # docker-compose
    # lazydocker
  ];

  home.file = {
    ".gitconfig".source = ../../.config/git/.gitconfig;
    ".agignore".source = ../../.config/ag/.agignore;
    ".gnupg/gpg-agent.conf".source = ../../.config/gnupg/gpg-agent.conf;
  };
}
