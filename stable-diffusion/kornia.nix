{ lib, fetchFromGitHub, pythonPackages, python, torch }:

python.pkgs.buildPythonPackage rec {
  pname = "kornia";
  version = "0.6.11";

  src = fetchFromGitHub {
    owner = "kornia";
    repo = "kornia";
    rev = "refs/tags/v${version}";
    hash = "sha256-APqITIt2P+16qp27dwLoAq9vY5CYpd49IWfYHTcZTSI=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    torch
    pythonPackages.packaging
  ];

  meta = with lib; {
    homepage = "https://github.com/kornia/kornia";
    description = "Differentiable Computer Vision Library";
    license = licenses.asl20;
  };
}
