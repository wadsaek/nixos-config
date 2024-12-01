{
  fetchFromGitHub,
  stdenv,
  eigen,
  lib
}:
stdenv.mkDerivation {
  pname = "literallySpinningDonut";
  version = "1.0.0";

  src = fetchFromGitHub{
    owner = "blueburb";
    repo = "literallySpinningDonut";
    rev = "11c3812a9504d19bd756396f9d86ab9b5f00d829";
    hash = "sha256-fOfENSLAyzbKeoOsmqEwVhIW5+gCU+vo+6h9nf9Wz3o=";
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

  meta = with lib;{
    description = "blue_birb's rendition of donut.c coded in c++";
    branch = "main";
    homepage = "https://github.com/blueburb/literallySpinningDonut";
    license = licenses.gpl3;
    mainProgram = "donut";
    platforms = platforms.all;
  };
}
