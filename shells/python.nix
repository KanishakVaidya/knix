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
    pypkgs.pip
    pypkgs.virtualenv
    pypkgs.ipython
    pypkgs.ty
    pypkgs.jupyterlab
    pypkgs.jupyterlab-vim

    # Formatters / linters
    ruff
    black
    isort

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
      pkgs.libGL
      pkgs.libGLU
    ]}:$LD_LIBRARY_PATH"

    if [ -d /run/opengl-driver/lib ]; then
      export LD_LIBRARY_PATH="/run/opengl-driver/lib:$LD_LIBRARY_PATH"
    fi

    echo "Python dev shell"
    echo "Python: $(python --version)"
    echo "uv: $(uv --version)"
  '';
}
