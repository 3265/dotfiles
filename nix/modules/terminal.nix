{ pkgs, pkgs-stable, ... }: {
  home.packages = [
    pkgs-stable.tmux
    pkgs-stable.screen
  ];

  home.file = {
    # Terminal multiplexer
    ".screenrc".source = ../../.config/screen/.screenrc;
    ".config/tmux".source = ../../.config/tmux;
  };
}
