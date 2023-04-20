{ lib, pythonPackages, python, torch }:

python.pkgs.buildPythonPackage rec {
  pname = "resize-right";
  version = "0.0.2";

  src = python.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-fcNbcs5AErd/fMkEmDUWN5OrmKWKuIk2EPsRn+Wa9SA=";
  };

  buildInputs = [
    torch
  ];

  meta = with lib; {
    homepage = "https://github.com/assafshocher/ResizeRight";
    description = "The correct way to resize images or tensors. For Numpy or Pytorch (differentiable).";
    license = licenses.mit;
  };
}
