{ lib, pythonPackages, python, torch }:

python.pkgs.buildPythonPackage rec {
  pname = "torchdiffeq";
  version = "0.2.3";

  src = python.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-/nX0NLkJCsDCdwLgK+0hRysPhwNb5lgfUe3F1AE+oxo=";
  };

  buildInputs = [
    torch
    pythonPackages.scipy
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/rtqichen/torchdiffeq";
    description = "Differentiable ODE solvers with full GPU support and O(1)-memory backpropagation.";
    license = licenses.mit;
  };
}
