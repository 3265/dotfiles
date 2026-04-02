{ config, lib, pkgs, ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    fish
  ];

  home.file = {
    # Fish
    ".config/fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/config.fish";
    ".config/fish/conf.d/fzf.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/conf.d/fzf.fish";
    ".config/fish/functions/__fzf_autojump.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/functions/__fzf_autojump.fish";
    ".config/fish/functions/__fzf_find_dir.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/functions/__fzf_find_dir.fish";
    ".config/fish/functions/__fzf_find_file.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/functions/__fzf_find_file.fish";
    ".config/fish/functions/__fzf_search_history.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/functions/__fzf_search_history.fish";
    ".config/fish/functions/explorer.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/functions/explorer.fish";
    ".config/fish/functions/fish_prompt.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/functions/fish_prompt.fish";
    ".config/fish/functions/load.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/functions/load.fish";
    ".config/fish/settings/alias.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/settings/alias.fish";
    ".config/fish/settings/basic.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/settings/basic.fish";
    ".config/fish/settings/env.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/settings/env.fish";
    ".config/fish/settings/git.fish".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/.config/fish/settings/git.fish";

    # Bash
    ".bashrc".source = ../../.config/bash/.bashrc;
    ".bashenv".source = ../../.config/bash/.bashenv;
    ".bash_profile".source = ../../.config/bash/.bash_profile;
    ".inputrc".source = ../../.config/bash/.inputrc;
    ".netrc".source = ../../.config/bash/.netrc;

    # SSH
    ".hushlogin".source = ../../.config/ssh/.hushlogin;

    # IME
    ".config/plasma-workspace/env/fcitx5.sh".source = ../../.config/plasma-workspace/env/fcitx5.sh;

    # Fusuma
    ".config/autostart/fusuma.desktop".source = ../../.config/autostart/fusuma.desktop;
  };
}
