{
  description = "My dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";  # 最新版
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";  # tmux 3.4用
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, ... }: {
    homeConfigurations."mike" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./nix/home.nix
        {
          _module.args.pkgs-stable = nixpkgs-stable.legacyPackages.x86_64-linux;
        }
      ];
    };
  };
}
