{ lib, fetchFromGitHub, pythonPackages, python, torch, torchvision, opencv }:

python.pkgs.buildPythonPackage rec {
  pname = "facexlib";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "xinntao";
    repo = "facexlib";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-2mqjGtrOigOxyGFEFZBK2/SqEhIv5cbrQU/bYDVje7Q=";
  };

  propagatedBuildInputs = [
    pythonPackages.cython
    (pythonPackages.filterpy.overridePythonAttrs (old: rec {
      doCheck = false;
    }))
    pythonPackages.numba
    pythonPackages.numpy
    opencv
    pythonPackages.pillow
    pythonPackages.scipy
    torch
    torchvision
    pythonPackages.tqdm
  ];

  preConfigure = ''
    substituteInPlace requirements.txt --replace "opencv-python" "opencv"
  '';

  pythonImportsCheck = [
    "facexlib"
  ];

  meta = with lib; {
    homepage = "https://github.com/xinntao/facexlib";
    description = "facexlib aims at providing ready-to-use face-related functions based on current SOTA open-source methods.";
    license = licenses.mit;
  };
}
