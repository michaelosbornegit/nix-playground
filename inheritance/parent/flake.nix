{
  description = "Parent devshell flake: Provides a few base python packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system} = rec {
        # This 'base' is a FUNCTION that accepts extraPackages.
        base = { extraPackages ? [] }:
          let
            pythonWithPackages = (pkgs.python3.withPackages (python-pkgs: [
              python-pkgs.requests
            ] ++ extraPackages));
          in
          pkgs.mkShell {
            name = "Python base shell";

            buildInputs = [
              pythonWithPackages
            ];

            shellHook = ''
              echo "Welcome to the PARENT devshell!"
              echo "Installed packages: requests"
              echo "Additional packages (if any): ${builtins.toJSON extraPackages}"
            '';
          };

        # Provide the flake’s "default" devShell by calling base with no extras
        default = base { };
      };
    };
}
