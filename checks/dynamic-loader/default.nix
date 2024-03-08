{
  lib,
  stdenv,
  haskell,
}: let
  ghc = haskell.packages.ghc98.ghc.withPackages (
    hp: with hp; [dynamic-loader base ghc-boot]
  );
in
  stdenv.mkDerivation {
    pname = "dynamic-loader-check";
    version = "0.0.0";
    src = ./.;
    nativeBuildInputs = [ghc];
    buildInputs = [ghc];
    buildPhase = ''
      runHook preBuild
      ghc --make -j$NIX_BUILD_CORES -dynamic -shared -fPIC Library.hs
      substituteInPlace Main.hs --replace-fail GHCBASE \"${ghc.out}\"
      ghc --make -j$NIX_BUILD_CORES -dynamic Main.hs
      ./Main
      runHook postBuild
    '';
    installPhase = ''
      runHook preInstall
      install Main $out
      runHook postInstall
    '';
  }
