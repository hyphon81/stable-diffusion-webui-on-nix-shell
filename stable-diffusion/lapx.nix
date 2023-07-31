{ lib, pkgs, pythonPackages, python }:

python.pkgs.buildPythonPackage rec {
  pname = "lapx";
  version = "0.5.4";

  src = python.pkgs.fetchPypi {
    inherit pname version format;
    dist = "cp310";
    python = "cp310";
    abi = "cp310";
    platform = "manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64";
    hash = "sha256-dsVJpT9hm3yKQYJOttQg5nOA9I9rqpZIH97HIp9MwAc=";
  };
  format = "wheel";

  propagatedBuildInputs = [
    pythonPackages.numpy
    pythonPackages.cython
  ];

  pythonImportsCheck = [
    #"lapx"
  ];
}
