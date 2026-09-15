{ pkgs }:

let
  python = pkgs.python314;
  pypkgs = python.pkgs;
in

pkgs.mkShell {
  packages = with pkgs; [
    python

    # Python tooling
    uv
    pyppkgs.pip
    pyppkgs.virtualenv
    pyppkgs.ipython

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
