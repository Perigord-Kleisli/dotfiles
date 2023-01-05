{ stdenv, lib, makeWrapper, luajitPackages, luajit }:

stdenv.mkDerivation rec {
  pname = "fennel-ls-${version}";
  version = "70e43483";

  src = builtins.fetchGit {
    url = "https://git.sr.ht/~xerool/fennel-ls";
    rev = "70e434839fdf9fad7512118d3f72e38aa8d3ca9f";
    ref = "main";
  };

  buildInputs = [ makeWrapper luajit luajitPackages.fennel ];
  makeFlags = [ ''FENNEL="${luajitPackages.fennel}/bin/fennel"'' ];

  installPhase = ''
    install -m755 -D fennel-ls "$out/bin/fennel-ls"
  '';

  meta = with lib; {
    description = "A language server for fennel-ls";
    homepage = "https://git.sr.ht/~xerool/fennel-ls";
    license = licenses.mit;
    maintainers = [ ];
    platforms = luajitPackages.fennel.meta.platforms;
  };
}
