{
  description = "Child devshell flake: Extends parent's VSCode environment";

  inputs = {
    # Replace the URL or path to your parent's flake below.
    parent.url = "path:../parent";

    # We still need nixpkgs ourselves in most flake setups
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, parent, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = 
        parent.devShells.${system}.base {
          # The child can add more VSCode extensions
          extraExtensions = [
            pkgs.vscode-extensions.hashicorp.terraform
            pkgs.vscode-extensions.esbenp.prettier-vscode
          ];

          # Possibly override or extend settings if your logic supports them
          extraSettings = {
            "editor.formatOnSave" = true;
            "python.analysis.typeCheckingMode" = "strict";
          };
        };
    };
}
