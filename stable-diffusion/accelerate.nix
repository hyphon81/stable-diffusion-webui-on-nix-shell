{ lib, fetchFromGitHub, pythonPackages, python, torch, torchvision }:

python.pkgs.buildPythonPackage rec {
  pname = "accelerate";
  version = "0.18.0";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = "accelerate";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-fCIvVbMaWAWzRfPc5/1CZq3gZ8kruuk9wBt8mzLHmyw=";
  };

  propagatedBuildInputs = [
    torch
    torchvision
    pythonPackages.packaging
    pythonPackages.psutil
  ];

  pythonImportsCheck = [
    "accelerate"
  ];

  meta = with lib; {
    homepage = "https://github.com/huggingface/accelerate";
    description = "A simple way to train and use PyTorch models with multi-GPU, TPU, mixed-precision";
    license = licenses.asl20;
  };
}
