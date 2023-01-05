{ stdenv, lib, fetchurl, zlib, autoPatchelfHook }:
stdenv.mkDerivation rec {
  name = "marksman";
  version = "2022-12-28";
  src = fetchurl {
    url =
      "https://github.com/artempyanykh/marksman/releases/download/${version}/${name}-linux";
    sha256 = "sha256-XpLJkHMjEOVwNWy8emMAy09nXjI/8QySE/IPE9QML5s=";
  };

  dontUnpack = true;
  dontBuild = true;
  buildInputs = [zlib stdenv.cc.cc.lib];
  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    install -m755 -D $src "$out/bin/${name}"
  '';

  meta = with lib; {
    description =
      "Write Markdown with code assist and intelligence in the comfort of your favourite editor";
    homepage = "https://github.com/artempyanykh/marksman";
    license = licenses.mit;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
