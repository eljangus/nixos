{lib}: dir: let
  inherit (builtins) filter;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix hasPrefix;

  files = map toString (listFilesRecursive dir);
in
  filter (
    p: hasSuffix ".nix" p && baseNameOf p != "default.nix" && !(hasPrefix "_" (baseNameOf p))
  )
  files
