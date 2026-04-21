{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Build tools
    gcc
    gnumake
    cmake

    # Basic utilities
    util-linux
    silver-searcher
    ripgrep
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
    git-secrets

    # Docker (note: Docker daemon needs system-level setup)
    # docker
    # docker-compose
    # lazydocker
  ];

  home.file = {
    ".gitconfig".source = ../../config/git/.gitconfig;
    ".agignore".source = ../../config/ag/.agignore;
    ".gnupg/gpg-agent.conf".source = ../../config/gnupg/gpg-agent.conf;
  };
}
