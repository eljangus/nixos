{
  name,
  host,
  description ? "Elias Schlosser",
  stateVersion ? "26.05",
  extraGroups ? [
    "networkmanager"
    "wheel"
  ],
}: {
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  isDarwin = config.nixpkgs.hostPlatform.isDarwin;

  homeDirectory =
    if isDarwin
    then "/Users/${name}"
    else "/home/${name}";

  nhPlatform =
    if isDarwin
    then "darwin"
    else "os";

  nhStage =
    if isDarwin
    then "build"
    else "boot";

  flakeRef = "~/nixos#${host}";
in {
  users.users.${name} =
    {
      inherit name description;
      home = homeDirectory;
      shell = pkgs.fish;
    }
    // lib.optionalAttrs (!isDarwin) {
      isNormalUser = true;
      inherit extraGroups;
      hashedPasswordFile = "/etc/nixos/secrets/${name}.txt";
    };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";

    users.${name} = {
      imports =
        [(self + "/modules/home-manager/common")]
        ++ lib.optional isDarwin (self + "/modules/home-manager/darwin")
        ++ lib.optional (!isDarwin) (self + "/modules/home-manager/nixos");

      home = {
        inherit stateVersion homeDirectory;
        username = name;
        sessionVariables = {
          EDITOR = "nvim";
        };
      };

      programs.fish.shellAliases = {
        nrs = "nh ${nhPlatform} switch ${flakeRef}";
        nrb = "nh ${nhPlatform} ${nhStage} ${flakeRef}";
      };
    };
  };
}
