{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup
    lsd
    fastmod
    mdbook
  ];
}
