{
  stdenv,
  lib,
  fetchzip,
}:
stdenv.mkDerivation rec {
  pname = "glsl_analyzer";
  version = "1.4.2";

  src = fetchzip {
    url = "https://github.com/nolanderc/glsl_analyzer/releases/download/v1.4.2/x86_64-linux-musl.zip";
    sha256 = "sha256-UpEFAdpnMYMMnv8WgzQF7TGDpX+8FR2K7rBbhIRF0Uc=";
  };

  installPhase = ''
    install -Dm 744 "$src/${pname}" "$out/bin/${pname}" 
  '';

  meta = {
    description = "Language server for GLSL (autocomplete, goto-definition, formatter, and more)";
    homepage = "https://github.com/nolanderc/glsl_analyzer";
    license = lib.licenses.gpl3;
  };
}
