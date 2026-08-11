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
      {
        home-manager.extraSpecialArgs = {inherit importTree;};
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
    nixosConfigurations = {
      wc = mkSystem "wc" "x86_64-linux";
      gnome = mkSystem "gnome" "x86_64-linux";
      kde = mkSystem "kde" "x86_64-linux";
    };

    darwinConfigurations = {
      mac = mkDarwin "mac" "aarch64-darwin";
    };
  };
}
