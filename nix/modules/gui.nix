{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # System tools
    gparted

    # Internet
    thunderbird
    filezilla

    # Office
    onlyoffice-desktopeditors

    # Android
    scrcpy
    android-studio

    # Recording
    screenkey
    obs-studio

    # Development
    flutter
    jetbrains-toolbox
    jetbrains.idea-oss  # formerly jetbrains.idea-community

    # Cloud
    # dropbox # deamon will need to be started manually

    # Commented out (install manually or uncomment if available)
    # google-chrome
    # vivaldi
    # vscode
    # obsidian
  ];
}
