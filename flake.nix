{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      with nixpkgs.legacyPackages.${system};
      let
        hl = haskell.lib;
        hsPkgs = haskell.packages.ghc98;

        hsPkgsFn = p: with p; [ attoparsec hspec optparse-applicative word8 ];
      in {
        devShells.default = mkShell {
          buildInputs = with hsPkgs; [
            (ghcWithPackages hsPkgsFn)
            cabal-gild
            cabal-install
            haskell-language-server
            hlint
          ];
        };
      });
}
