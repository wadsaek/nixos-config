{
  fetchFromGitHub,
  stdenv,
  eigen,
  lib,
}:
stdenv.mkDerivation {
  pname = "literallySpinningDonut";
  version = "optimized-through-the-roof";

  src = fetchFromGitHub {
    owner = "blueburb";
    repo = "literallySpinningDonut";
    rev = "6cad9a6d33107c3ce7ceac648edaf97c23e5a102";
    hash = "sha256-QSdqOUvXBsuV+Sj6qEc6VU5PZjesRZH6IUjHQ7PG2xM=";
  };
  buildPhase = ''
    gcc main.cpp -lstdc++ -lm -o donut
  '';

  installPhase = ''
    mkdir -p $out/bin;
    mv donut $out/bin/donut
  '';
  buildInputs = [
    eigen
  ];

  meta = {
    description = "blue_birb's rendition of donut.c coded in c++";
    branch = "main";
    homepage = "https://github.com/blueburb/literallySpinningDonut";
    license = lib.licenses.gpl3;
    mainProgram = "donut";
    platforms = lib.platforms.all;
  };
}
