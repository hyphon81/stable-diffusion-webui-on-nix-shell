{ lib, pythonPackages, python }:

python.pkgs.buildPythonPackage rec {
  pname = "opencv-contrib-python";
  version = "4.7.0.72";

  src = python.pkgs.fetchPypi {
    inherit version format;
    pname = "opencv_contrib_python";
    dist = "cp37";
    python = "cp37";
    abi = "abi3";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    hash = "sha256-tUwui7Y242fSm95I+uKqUsQ7eCJlz2WDih/oUgBs3ZQ=";
  };
  format = "wheel";

  buildInputs = [
    pythonPackages.numpy
  ];

  doCheck = false;
}
