{ config, pkgs, ... }: {
  # Import all modules
  imports = [
    ./modules/base.nix
    ./modules/shell.nix
    ./modules/editor.nix
    ./modules/terminal.nix
    ./modules/python.nix
    ./modules/blog.nix
    ./modules/languages.nix
    ./modules/cloud.nix
    # ./modules/gui.nix       # GUI applications
  ];

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "mike";
  home.homeDirectory = "/home/mike";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    settings = {
      user.name = "mike";
      user.email = "your-email@example.com";
    };
  };
}
