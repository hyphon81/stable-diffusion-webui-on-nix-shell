{ lib, pythonPackages, python, rustPlatform }:

python.pkgs.buildPythonPackage rec {
  pname = "safetensors";
  version = "0.4.2";
  format = "wheel";

  src = python.pkgs.fetchPypi {
    inherit pname version format;
    dist = "cp311";
    python = "cp311";
    abi = "cp311";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    sha256 = "sha256-Aml/jyvoyjw3pJWHAtvbGGREfvdl4YtTKKFhcCLc8WQ=";
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
