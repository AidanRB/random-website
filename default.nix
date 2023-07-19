with (import <nixpkgs> { });

mkShell {
  buildInputs = [
    dig
    moreutils
    python311
    python311Packages.requests
    python311Packages.jupyter
    python311Packages.notebook
    python311Packages.ipykernel
  ];
}
