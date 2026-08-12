{ pkgs }:

let
  python = pkgs.python312;
in

pkgs.mkShell {
  packages = with pkgs; [
    python

    # Python tooling
    uv
    python312Packages.pip
    python312Packages.virtualenv
    python312Packages.ipython

    # Formatters / linters
    ruff
    black
    isort
    basedpyright

    # Build tools
    gcc
    pkg-config

    # Common native libraries
    openssl
    zlib
    sqlite
    libffi

    git
  ];

  shellHook = ''
    export UV_PYTHON=${python}/bin/python
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc
      pkgs.zlib
      pkgs.openssl
      pkgs.libffi
    ]}:$LD_LIBRARY_PATH"

    echo "Python dev shell"
    echo "Python: $(python --version)"
    echo "uv: $(uv --version)"
  '';
}
