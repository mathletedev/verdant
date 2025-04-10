{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    pkgs.tailwindcss
  ];

  shellHook = ''
    ln -sf ${pkgs.tailwindcss}/bin/tailwindcss ./_build/tailwind-linux-x64
  '';
}
