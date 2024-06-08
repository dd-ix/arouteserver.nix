{ pkgs }:

let
  aggregate6 = pkgs.python3Packages.buildPythonPackage rec {
    pname = "aggregate6";
    version = "1.0.12";
    format = "pyproject";

    src = pkgs.fetchFromGitHub {
      owner = "job";
      repo = pname;
      rev = version;
      hash = "sha256-tBo9LSmEu/0KPSeg17dlh7ngUvP9GyW6b01qqpr5Bx0=";
    };

    postPatch = ''
      substituteInPlace setup.py --replace-fail 'py-radix==0.10.0' 'py-radix-sr'
    '';

    nativeBuildInputs = with pkgs.python3Packages; [
      setuptools
    ];

    nativeCheckInputs = with pkgs.python3Packages; [
      pytest
      mock
      coverage
      nose
    ];

    propagatedBuildInputs = with pkgs.python3Packages; [
      py-radix-sr
    ];

    checkPhase = ''
      runHook preCheck

      pytest -vs -x tests

      runHook postCheck
    '';

    doCheck = true;
  };
in
pkgs.python3Packages.buildPythonPackage rec {
  pname = "arouteserver";
  version = "1.22.1";
  format = "pyproject";

  src = pkgs.fetchFromGitHub {
    #inherit pname version;
    owner = "pierky";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-8xYfTjtsMoLuDpJ8oLnDRP2oIcZvzlMESlREc2S1DmU=";
  };

  postPatch = ''
    substituteInPlace requirements.txt --replace-fail 'packaging~=21.0' 'packaging'
  '';

  nativeBuildInputs = with pkgs.python3Packages; [
    setuptools
  ];

  buildInputs = with pkgs; [
    bgpq4
  ];

  nativeCheckInputs = with pkgs.python3Packages;[
    pytest
  ];

  checkInputs = with pkgs.python3Packages; [
    requests-mock
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

  checkPhase = ''
    runHook preCheck

    pytest -vs -x tests/static/

    runHook postCheck
  '';

  doCheck = true;
}

