{
  description = "Parent devshell flake: Extends parents python environment";

  inputs = {
    # Replace the URL or path to your parent's flake below.
    parent.url = "github:michaelosbornegit/nix-playground/inheritance/parent";

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
          extraExtensions = python-pkgs: [
            python-pkgs.preggy
          ];
        };
    };
}
