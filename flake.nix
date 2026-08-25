{
  description = "NixOS and nix-darwin flake with home-manager, multiple users and DEs/WCs";

  outputs = args @ {self, ...}: let
    inputs = import ./.tack {
      overrides = args.tackOverrides or {};
    };
    inherit (inputs.nixpkgs) lib;
    importTree = import ./lib/import-tree.nix {inherit lib;};
    specialArgs = {inherit inputs self importTree;};
    commonModules = [
      ./modules/system/common
      ./overlays
      {
        home-manager.extraSpecialArgs = {inherit self inputs importTree;};
        home-manager.sharedModules = [inputs.nvf.homeManagerModules.default];
      }
    ];
    mkSystem = hostname: system:
      lib.nixosSystem {
        inherit specialArgs;
        modules =
          commonModules
          ++ [
            {nixpkgs.hostPlatform = system;}
            ./hosts/${hostname}
            ./modules/system/nixos
            inputs.home-manager.nixosModules.home-manager
          ];
      };
    mkDarwin = hostname: system:
      inputs.nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        modules =
          commonModules
          ++ [
            {nixpkgs.hostPlatform = system;}
            ./hosts/${hostname}
            ./modules/system/darwin
            inputs.home-manager.darwinModules.home-manager
          ];
      };
  in {
    formatter = lib.genAttrs ["x86_64-linux" "aarch64-darwin"] (
      system: inputs.nixpkgs.legacyPackages.${system}.alejandra
    );
    nixosConfigurations = lib.genAttrs ["wc" "gnome" "kde"] (hostname: mkSystem hostname "x86_64-linux");
    darwinConfigurations = lib.genAttrs ["mac"] (hostname: mkDarwin hostname "aarch64-darwin");
  };
}
