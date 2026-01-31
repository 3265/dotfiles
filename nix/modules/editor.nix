{ pkgs, ... }: {
  home.packages = with pkgs; [
    vim-full
    neovim
    emacs
  ];

  home.file = {
    # Vim
    ".vimrc".source = ../../.config/vim/.vimrc;
    ".ideavimrc".source = ../../.config/vim/.ideavimrc;
    ".config/nvim/init.vim".source = ../../.config/nvim/init.vim;

    # Emacs
    ".emacs.d/init.el".source = ../../.config/emacs/init.el;

    # Kate
    ".config/kate/lspclient/settings.json".source = ../../.config/kate/lspclient/settings.json;
  };
}
