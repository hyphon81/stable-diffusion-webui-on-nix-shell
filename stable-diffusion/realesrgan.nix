{ lib, fetchFromGitHub, pythonPackages, python, torch, torchvision,
  opencv, basicsr, facexlib, gfpgan
}:

python.pkgs.buildPythonPackage rec {
  pname = "realesrgan";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "xinntao";
    repo = "Real-ESRGAN";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-pdOYDOAnKKt+5M6dD8ksTbFoA8EwjGUZVx+UGpxCF6c=";
  };

  propagatedBuildInputs = [
    basicsr
    facexlib
    gfpgan
    pythonPackages.numpy
    opencv
    pythonPackages.pillow
    torch
    torchvision
    pythonPackages.tqdm
  ];

  preConfigure = ''
    substituteInPlace requirements.txt --replace "opencv-python" "opencv"
  '';

  doCheck = false;

  pythonImportsCheck = [
    "realesrgan"
  ];

  meta = with lib; {
    homepage = "https://github.com/xinntao/Real-ESRGAN";
    description = "Real-ESRGAN aims at developing Practical Algorithms for General Image/Video Restoration.";
    license = licenses.bsd3;
  };
}
