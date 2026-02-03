{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    vim-full
    neovim
    emacs
  ];

  home.file = {
    # Vim
    ".vimrc".source = ../../.config/vim/.vimrc;
    ".ideavimrc".source = ../../.config/vim/.ideavimrc;
    ".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/nvim/init.lua";

    # Emacs
    ".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/emacs/init.el";

    # Kate
    ".config/kate/lspclient/settings.json".source = ../../.config/kate/lspclient/settings.json;
  };
}
