{ lib, pythonPackages, python, rustPlatform }:

python.pkgs.buildPythonPackage rec {
  pname = "safetensors";
  version = "0.3.0";
  format = "wheel";

  src = python.pkgs.fetchPypi {
    inherit pname version format;
    dist = "cp310";
    python = "cp310";
    abi = "cp310";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    sha256 = "sha256-fuxqxfaRj7iV6zrsM9C+jpH9GP3qr5TKG+jPlFynSDg=";
  };

  buildInputs = [
  ];

  pythonImportsCheck = [
    "safetensors"
  ];

  meta = with lib; {
    homepage = "https://github.com/huggingface/safetensors";
    description = "Simple, safe way to store and distribute tensors";
    license = licenses.asl20;
  };
}
