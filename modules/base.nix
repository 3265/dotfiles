{ pkgs, pkgs-stable, ... }: {
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
    emacs
    cmatrix
    apacheHttpd
    whois
    curl
    inxi
    htop
    vim
    marksman  # Markdown LSP for Kate
  ] ++ [
    # Stable packages
    pkgs-stable.tmux    # tmux 3.4
    pkgs-stable.screen
  ];
}
