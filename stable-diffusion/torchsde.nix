{ lib, fetchFromGitHub, pythonPackages, python, torch, trampoline }:

python.pkgs.buildPythonPackage rec {
  pname = "torchsde";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "google-research";
    repo = "torchsde";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-qQ7oswm0qTdq1xpQElt5cd3K0zskH+H/lgyEnxbCqsI=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    pythonPackages.boltons
    pythonPackages.numpy
    pythonPackages.scipy
    torch
    trampoline
  ];

  preConfigure = ''
    substituteInPlace setup.py --replace "numpy==1.19.*" "numpy>=1.19"
    substituteInPlace setup.py --replace "scipy==1.5.*" "scipy>=1.5"
  '';

  pythonImportsCheck = [
    "torchsde"
  ];

  meta = with lib; {
    homepage = "https://github.com/google-research/torchsde";
    description = "Differentiable SDE solvers with GPU support and efficient sensitivity analysis.";
    license = licenses.asl20;
  };
}
