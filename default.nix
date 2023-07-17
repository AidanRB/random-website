with (import <nixpkgs> { });

mkShell {
  buildInputs = [
    dig
    moreutils
  ];
}
