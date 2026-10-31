{ pkgs ? import <nixpkgs> {} }:

{
  openigi = pkgs.callPackage ./openigi.nix { };
  # my-binary-two = pkgs.callPackage ./my-binary-two.nix { };
}
