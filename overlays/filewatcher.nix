{
  makeWrapper,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "filewatcher";
  version = "1.2.0";
  src = fetchFromGitHub {
    owner = "coolsoft-ita";
    repo = "filewatcher";
    rev = "6cf3558817a6d66582b0d1d5b4f53386b0825e05";
    sha256 = "E+gD7/gvLHtU/FCEtmD8lz2f9wspnSjGCqZp8o1id2Q=";
  };
  buildInputs = [makeWrapper];

  buildPhase = ''
    (cd ./native-app
      make
    )
  '';

  installPhase = ''
    install -m 744 -D ./native-app/filewatcher "$out/bin/filewatcher"
  '';
}
