{ lib, pythonPackages, python, torch, torchvision }:

python.pkgs.buildPythonPackage rec {
  pname = "xformers";
  version = "0.0.18";

  src = python.pkgs.fetchPypi {
    inherit pname version format;
    dist = "cp310";
    python = "cp310";
    abi = "cp310";
    platform = "manylinux2014_x86_64";
    hash = "sha256-OYqjlwNbXwBHm+/+NnHQtjnB/1qO2tNAzFUMIysRhxw=";
  };

  format = "wheel";

  propagatedBuildInputs = [
    torch
    torchvision
  ];

  meta = with lib; {
    homepage = "https://pypi.org/project/xformers/";
    description = "XFormers: A collection of composable Transformer building blocks.";
    license = licenses.bsd;
  };
}
