{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    pkgs.tailwindcss
  ];

  shellHook = ''
    ln -s assets/tailwind.config.js tailwind.config.js
    ln -sf ${pkgs.tailwindcss}/bin/tailwindcss ./_build/tailwind-linux-x64
  '';
}
