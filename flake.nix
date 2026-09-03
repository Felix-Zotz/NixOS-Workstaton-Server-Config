{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
  };
  outputs = { nixpkgs, playit-nixos-module, ... }: {
    nixosConfigurations."Home-Server" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ playit-nixos-module.nixosModules.default ./configuration.nix ];
    };
  };
}
