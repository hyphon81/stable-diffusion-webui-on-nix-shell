{ lib, fetchFromGitHub, pythonPackages, python, torch, torchvision, opencv }:

python.pkgs.buildPythonPackage rec {
  pname = "invisible-watermark";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "ShieldMnt";
    repo = "invisible-watermark";
    rev = "refs/tags/${version}";
    sha256 = "sha256-NGDPEETuM7rYbo8kXYoRWLJWpa/lWLKEvaaiDzSWYZ4=";
  };

  propagatedBuildInputs = [
    torch
    torchvision
    opencv
    (pythonPackages.onnx.override {
      protobuf = pythonPackages.protobuf3;
    })
    pythonPackages.onnxruntime
    pythonPackages.pywavelets
    pythonPackages.pillow
  ];

  preConfigure = ''
    substituteInPlace setup.py --replace "opencv-python" "opencv"
  '';

  pythonImportsCheck = [
    "imwatermark"
  ];

  meta = with lib; {
    homepage = "https://github.com/ShieldMnt/invisible-watermark";
    description = "python library for invisible image watermark (blind image watermark)";
    license = licenses.mit;
  };
}
