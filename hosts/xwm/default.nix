{
  self,
  importTree,
  ...
}: {
  imports =
    [
      (self + "/systems/Apollo")
      (import (self + "/lib/mk-user.nix") {
        name = "elias";
        host = "xwm";
      })
    ]
    ++ importTree ./.;
}
