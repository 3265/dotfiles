{ pkgs, ... }: {
  home.packages = with pkgs; [
    mdbook
    marksman  # Markdown LSP for Kate
    hugo
  ];
}
