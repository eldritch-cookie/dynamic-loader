module Main where

import GHC.BaseDir
import GHC.Platform.ArchOS
import GHC.Platform.Host
import GHC.Version
import System.FilePath
import System.Plugins.DynamicLoader

main :: IO ()
main = do
  Just dir <- getBaseDir
  let
    archString = stringEncodeArch hostPlatformArch
    oSString = stringEncodeOS hostPlatformOS
    baseVersion = "base-4.19.1.0-inplace"
    ghcDir =
      GHCBASE </> "lib" </> "ghc-"
        <> cProjectVersion
          </> "lib"
          </> archString
        <> "-"
        <> oSString
        <> "-ghc-"
        <> cProjectVersion
          </> baseVersion
  putStrLn ghcDir
  base <- loadPackage "base-4.19.1.0-inplace" (Just ghcDir) (Just "libHS") (Just "a")
  mod <- loadModule "Library" (Just ".") Nothing
  resolveFunctions
  f <- loadFunction mod "myFunc"
  print @Int $ f 2 2
