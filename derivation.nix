{ pkgs }:

let
  aggregate6 = pkgs.python3Packages.buildPythonPackage rec {
    pname = "aggregate6";
    version = "1.0.12";
    format = "pyproject";

    src = pkgs.fetchPypi {
      inherit pname version;
      hash = "sha256-vg14uOhPltsvxn0XlV0W9gy9dq3+vZpi/h3Hytmyc9k=";
    };

    nativeBuildInputs = with pkgs.python3Packages; [
      setuptools
    ];

    nativeCheckInputs = with pkgs.python3Packages; [
      mock
      coverage
      nose
    ];

    propagatedBuildInputs = with pkgs.python3Packages; [
      py-radix-sr
    ];

    # TODO: execute tests
    doCheck = true;
  };
in
pkgs.python3Packages.buildPythonPackage rec {
  pname = "arouteserver";
  version = "1.21.6";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-JQFtVrbinva+w8WS2r+d/3aUxeocD/i5lh2DvSl3YLE=";
  };

  nativeBuildInputs = with pkgs.python3Packages; [
    setuptools
  ];

  buildInputs = with pkgs; [
    bgpq4
  ];

  propagatedBuildInputs = with pkgs.python3Packages; [
    aggregate6
    jinja2
    pyyaml
    requests
    packaging
    urllib3
    # WHAT??? -> https://github.com/search?q=repo%3Apierky%2Farouteserver%20pkg_resources&type=code
    setuptools
  ];

  doCheck = false;
}

