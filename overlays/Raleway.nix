{ stdenv,lib, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "raleway-${version}";
  version = "2016-08-30";

  src = fetchFromGitHub {
    owner = "impallari";
    repo = "Raleway";
    rev = "6c67ab1f7aa65c442bd2745bb9d4ef1cd7bc01fa";
    sha256 = "2ubPmqYxg2gVeYQpI917HSFBLNEuuc1MMNtB5OBA+MQ=";
  };
  strictDeps = true;
  dontConfigure = true;
  dontBuild = true;
  dontPatch = true;

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out/
    rm $out/README.md
  '';

  meta = {
    description = "Raleway is an elegant sans-serif typeface family";

    longDescription = ''
      Initially designed by Matt McInerney as a single thin weight, it was
      expanded into a 9 weight family by Pablo Impallari and Rodrigo Fuenzalida
      in 2012 and iKerned by Igino Marini. In 2013 the Italics where added.
      It is a display face and the download features both old style and lining
      numerals, standard and discretionary ligatures, a pretty complete set of
      diacritics, as well as a stylistic alternate inspired by more geometric
      sans-serif typefaces than its neo-grotesque inspired default character
      set.
      It also has a sister display family, Raleway Dots.
    '';

    homepage = "https://github.com/impallari/Raleway";
    license = lib.licenses.ofl;

    maintainers = with lib.maintainers; [ Profpatsch ];
  };
}
