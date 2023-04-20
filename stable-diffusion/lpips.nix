{ lib, fetchFromGitHub, pythonPackages, python, torch, torchvision, opencv }:

python.pkgs.buildPythonPackage rec {
  pname = "lpips";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "richzhang";
    repo = "PerceptualSimilarity";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-dIQ9B/HV/2kUnXLXNxAZKHmv/Xv37kl2n6+8IfwIALE=";
  };

  buildInputs = [
    torch
    torchvision
    opencv
    pythonPackages.tqdm
  ];

  preConfigure = ''
    substituteInPlace requirements.txt --replace "opencv-python" "opencv"
  '';

  pythonImportsCheck = [
    "lpips"
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/richzhang/PerceptualSimilarity";
    description = "The Unreasonable Effectiveness of Deep Features as a Perceptual Metric";
    license = licenses.bsd2;
  };
}
