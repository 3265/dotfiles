{ pkgs, ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    fish
  ];

  home.file = {
    # Vim
    ".vimrc".source = ../.config/vim/.vimrc;
    ".ideavimrc".source = ../.config/vim/.ideavimrc;
    
    # Terminal multiplexer
    ".screenrc".source = ../.config/screen/.screenrc;
    ".config/tmux".source = ../.config/tmux;
    
    # Fish
    ".config/fish/config.fish".source = ../.config/fish/config.fish;
    ".config/fish/conf.d".source = ../.config/fish/conf.d;
    ".config/fish/functions".source = ../.config/fish/functions;
    ".config/fish/settings".source = ../.config/fish/settings;
    
    # Bash
    ".bashrc".source = ../.config/bash/.bashrc;
    ".bashenv".source = ../.config/bash/.bashenv;
    ".bash_profile".source = ../.config/bash/.bash_profile;
    ".inputrc".source = ../.config/bash/.inputrc;
    ".netrc".source = ../.config/bash/.netrc;
    
    # Emacs
    ".emacs.d/init.el".source = ../.config/emacs/init.el;
    
    # SSH
    ".hushlogin".source = ../.config/ssh/.hushlogin;
    
    # IME
    ".config/plasma-workspace/env/fcitx5.sh".source = ../.config/plasma-workspace/env/fcitx5.sh;
    
    # Kate
    ".config/kate/lspclient/settings.json".source = ../.config/kate/lspclient/settings.json;
    
    # Fusuma
    ".config/autostart/fusuma.desktop".source = ../.config/autostart/fusuma.desktop;
  };
}
