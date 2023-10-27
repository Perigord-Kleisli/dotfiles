{ stdenv,lib, fetchurl }:

stdenv.mkDerivation rec {
  pname = "Icomoon-Feather-${version}";
  version = "1.0";

  src = fetchurl {
    url = "https://github.com/adi1090x/rofi/raw/master/fonts/Icomoon-Feather.ttf";
    sha256 = "sha256-kKyBYq8r6+aL/vLWLgVqgTFjPWzGhYdqsMgmQhOBAVg=";
  };

  installPhase = ''
    install -Dm 644 $src "$out/share/fonts/TTF/icomoon-feather.ttf" 
  '';
  dontUnpack = true;

  meta = {
    description = "Icomoon Feather Font";

    homepage = "https://github.com/adi1090x/rofi/blob/master/fonts/Icomoon-Feather.ttf";
    license = lib.licenses.gpl3;

  };
}
