{ lib, fetchFromGitHub, pythonPackages, python, torch, torchvision,
  tensorboard, opencv
}:

python.pkgs.buildPythonPackage rec {
  pname = "basicsr";
  version = "1.4.2";

  src = fetchFromGitHub {
    owner = "XPixelGroup";
    repo = "BasicSR";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-UfwwwF0h0c5oPeGhj0w5Zw2edjPNoQWNG4pKHBwMU2I=";
  };

  propagatedBuildInputs = [
    pythonPackages.cython
    pythonPackages.addict
    pythonPackages.future
    pythonPackages.lmdb
    pythonPackages.numpy
    opencv
    pythonPackages.pillow
    pythonPackages.pyyaml
    pythonPackages.requests
    pythonPackages.scikitimage
    pythonPackages.scipy
    tensorboard
    torch
    torchvision
    pythonPackages.tqdm
    pythonPackages.yapf
  ];

  preConfigure = ''
    substituteInPlace requirements.txt --replace "opencv-python" "opencv"
    substituteInPlace requirements.txt --replace "tb-nightly" "tensorboard"
  '';

  doCheck = false;

  pythonImportsCheck = [
    "basicsr"
  ];

  meta = with lib; {
    homepage = "https://github.com/XPixelGroup/BasicSR";
    description = "Open Source Image and Video Restoration Toolbox for Super-resolution, Denoise, Deblurring, etc. Currently, it includes EDSR, RCAN, SRResNet, SRGAN, ESRGAN, EDVR, BasicVSR, SwinIR, ECBSR, etc. Also support StyleGAN2, DFDNet.";
    license = licenses.asl20;
  };
}
