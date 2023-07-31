{ lib, callPackage, fetchFromGitHub, pythonPackages, python,
  torch, torchvision, opencv
}:

let
  lapx = callPackage ./lapx.nix {
    python = python;
    pythonPackages = pythonPackages;
  };
in

python.pkgs.buildPythonPackage rec {
  pname = "ultralytics";
  version = "8.0.145";

  #src = python.pkgs.fetchPypi {
  #  inherit pname version format;
  #  dist = "py3";
  #  python = "py3";
  #  hash = "sha256-X8yigTkaBsf8W2s8N32be0rmdlXRWF6ctgJt4sAtqsg=";
  #};
  #format = "wheel";

  src = fetchFromGitHub {
    owner = "ultralytics";
    repo = "ultralytics";
    rev = "2ee1478";
    sha256 = "sha256-WLIUKG5EbwHEQyuYpl/JqDQWJSjk1ULddbiSroMD/hk=";
  };

  preConfigure = ''
    substituteInPlace requirements.txt --replace "opencv-python" "opencv"
    mkdir -p .config
  '';

  propagatedBuildInputs = [
    torch
    torchvision
    pythonPackages.psutil
    pythonPackages.pandas
    pythonPackages.py-cpuinfo
    pythonPackages.tqdm
    opencv
    pythonPackages.matplotlib
    pythonPackages.seaborn
    lapx
  ];

  MPLCONFIGDIR = ".config";

  pythonImportsCheck = [
    "ultralytics"
  ];

  doCheck = false;
}
