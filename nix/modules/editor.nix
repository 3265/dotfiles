{ pkgs, ... }: {
  home.packages = with pkgs; [
    vim-full
    emacs
  ];

  home.file = {
    # Vim
    ".vimrc".source = ../../.config/vim/.vimrc;
    ".ideavimrc".source = ../../.config/vim/.ideavimrc;

    # Emacs
    ".emacs.d/init.el".source = ../../.config/emacs/init.el;

    # Kate
    ".config/kate/lspclient/settings.json".source = ../../.config/kate/lspclient/settings.json;
  };
}
