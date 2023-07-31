{ lib, fetchFromGitHub, pythonPackages, python, iopath }:

python.pkgs.buildPythonPackage rec {
  pname = "fvcore";
  version = "0.1.9";

  src = fetchFromGitHub {
    owner = "facebookresearch";
    repo = "fvcore";
    rev = "0f2b23b";
    sha256 = "sha256-HzznEBZUAfwJX21rZJ5GQd6CFzv23XPrnT8oVzbEdFc=";
  };

  propagatedBuildInputs = [
    pythonPackages.numpy
    pythonPackages.yacs
    pythonPackages.pyyaml
    pythonPackages.tqdm
    pythonPackages.termcolor
    pythonPackages.pillow
    pythonPackages.tabulate
    iopath
  ];

  pythonImportsCheck = [
    "fvcore"
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/facebookresearch/fvcore";
    description = "Collection of common code that's shared among different research projects in FAIR computer vision team.";
    license = licenses.asl20;
  };
}
