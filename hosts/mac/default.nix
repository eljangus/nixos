{
  self,
  importTree,
  ...
}: {
  imports =
    [
      (self + "/systems/Mac")
      (import (self + "/lib/mk-user.nix") {
        name = "elias";
        host = "mac";
      })
    ]
    ++ importTree ./.;
}
