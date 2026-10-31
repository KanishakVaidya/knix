 {
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  zlib
}:

stdenv.mkDerivation rec {
  pname = "openigi";
  version = "0.5.6";

  src = fetchurl {
    url = "https://github.com/OpenIGI/OpenIGI/releases/download/v${version}/openigi-game-${version}-linux-x64";
    hash = "sha256-pLuWsru5XNckvMiS4c9IXVMpQthnuSWVOAR+ph78oR0=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [ stdenv.cc.cc.lib zlib ];

  dontUnpack = true;

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 $src $out/bin/openigi
  '';

  meta = with lib; {
    homepage = "https://openigi.com/";
    description = "Open IGI";
    platforms = platforms.linux;
  };
}

