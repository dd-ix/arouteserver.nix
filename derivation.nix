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
  version = "1.21.5";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-S/2eFfIRL26OaMUZQ0B628tmWjyaLqQCUmGTVqBBSsA=";
  };

  patches = [
    # fix http downloads
    (pkgs.fetchpatch {
      url = "https://github.com/dd-ix/arouteserver/commit/fc0e78acb78c4ccb1a90db416456ccf03cbf5a42.patch";
      hash = "sha256-SfNmF1t0veCItpLPf4e6zXtNpu2pj3gpCu2b3Bca8gI=";
    })
  ];


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

