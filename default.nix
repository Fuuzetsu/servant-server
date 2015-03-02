{ pkgs ? import <nixpkgs> { config.allowUnfree = true; }
, src ?  builtins.filterSource (path: type:
    type != "unknown" &&
    baseNameOf path != ".git" &&
    baseNameOf path != "result" &&
    baseNameOf path != "dist") ./.
}:
let
  servant02 = pkgs.fetchgit {
    url = https://github.com/haskell-servant/servant.git;
    rev = "refs/heads/servant-0.2";
    sha256 = "0mcn9d8hnijws1p8y6h3r0298f1x8mya2nshyi46mprrj2kn8wmm";
  };
  servant = import servant02 { inherit pkgs; };
in
pkgs.haskellPackages.buildLocalCabalWithArgs {
  name = "servant-server";
  inherit src;
  args = { inherit servant ; };
}
