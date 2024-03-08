{
  lib,
  pkgs,
  config,
  self',
  system,
  ...
}: {
  checks = {
    dynamic-loader = pkgs.callPackage ./dynamic-loader {};
  };
}
