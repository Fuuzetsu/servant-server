{ pkgs ? import <nixpkgs> { config.allowUnfree = true; }
, src ?  builtins.filterSource (path: type:
    type != "unknown" &&
    baseNameOf path != ".git" &&
    baseNameOf path != "result" &&
    baseNameOf path != "dist") ./.
}:
let
  servant03 = pkgs.fetchgit {
    url = https://github.com/haskell-servant/servant.git;
    rev = "refs/heads/servant-0.3";
    sha256 = "014xxlbiq5x7yhw4hx6xswckj2vwdn29rw77cznfnkld3srgc3r3";
  };
  servant = import servant03 { inherit pkgs; };
in
pkgs.haskellPackages.buildLocalCabalWithArgs {
  name = "servant-server";
  inherit src;
  args = { inherit servant ; };
}
