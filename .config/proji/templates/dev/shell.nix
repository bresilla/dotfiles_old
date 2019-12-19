with import <nixpkgs> {}; rec {
  cplateEnv = stdenv.mkDerivation {
    name = "python";
    buildInputs = [ stdenv
                    pkgconfig
                    gcc
                    xorg.libX11
                    ncurses
                  ];
  };
}
