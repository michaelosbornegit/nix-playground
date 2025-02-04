{
  description = "Parent devshell flake: Extends parents python environment";

  inputs = {
    # Replace the URL or path to your parent's flake below.
    parent.url = "github:michaelosbornegit/nix-playground?rev=0e3d58cbe350e49915e87205bd8ca24db0ea1bd4&dir=inheritance/parent";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, parent, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = 
        parent.devShells.${system}.base {
          # The child can add more python packages
          extraPackages = python-pkgs: [
            python-pkgs.preggy
          ];
        };

        shellHook = ''
          echo "Welcome to the CHILD devshell!"
        '';
    };
}
