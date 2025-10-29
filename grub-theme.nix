# /etc/nixos/grub-theme.nix
{ stdenvNoCC, src }:

stdenvNoCC.mkDerivation {
  name = "cybertext-grub";
  inherit src;
  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out/
  '';
}
