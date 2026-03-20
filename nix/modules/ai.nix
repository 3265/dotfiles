{ pkgs, ... }: {
  home.packages = with pkgs; [
    codex
    claude-code
  ];
}
