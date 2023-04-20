{ lib, fetchFromGitHub, pythonPackages, python, torch, torchvision,
  tensorboard, opencv, basicsr, facexlib
}:

python.pkgs.buildPythonPackage rec {
  pname = "gfpgan";
  version = "1.3.8";

  src = fetchFromGitHub {
    owner = "TencentARC";
    repo = "GFPGAN";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-frJ3hSniHvCSEPB1awJsXLuUxYRRMbV9GS4GSPKwXOg=";
  };

  propagatedBuildInputs = [
    basicsr
    facexlib
    pythonPackages.lmdb
    pythonPackages.numpy
    opencv
    pythonPackages.yapf
    pythonPackages.tqdm
    torch
    torchvision
    pythonPackages.pyyaml
    pythonPackages.scipy
    tensorboard
  ];

  preConfigure = ''
    substituteInPlace requirements.txt --replace "opencv-python" "opencv"
    substituteInPlace requirements.txt --replace "tb-nightly" "tensorboard"
  '';

  pythonImportsCheck = [
    "basicsr"
    "facexlib"
    "gfpgan"
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/TencentARC/GFPGAN";
    description = "GFPGAN aims at developing a Practical Algorithm for Real-world Face Restoration.";
  };
}
