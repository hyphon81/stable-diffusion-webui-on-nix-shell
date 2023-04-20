{ lib, pythonPackages, python, torch, torchvision }:

python.pkgs.buildPythonPackage rec {
  pname = "clean-fid";
  version = "0.1.35";
  format = "wheel";

  src = python.pkgs.fetchPypi {
    pname = "clean_fid";
    inherit version format;
    dist = "py3";
    python = "py3";
    hash = "sha256-dXz0nXXevpsHqxSVX+WchFopberwYWFTtAxedbPPh/s=";
  };

  buildInputs = [
    torch
    torchvision
    pythonPackages.tqdm
  ];

  pythonImportsCheck = [
    "cleanfid"
  ];

  meta = with lib; {
    homepage = "https://github.com/GaParmar/clean-fid";
    description = "PyTorch - FID calculation with proper image resizing and quantization steps [CVPR 2022]";
    license = licenses.mit;
  };
}
