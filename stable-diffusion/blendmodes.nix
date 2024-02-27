{ lib, pythonPackages, python, poetry }:

python.pkgs.buildPythonPackage rec {
  pname = "blendmodes";
  version = "2023";
  format = "pyproject";

  src = python.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-EI7baRFGhoCzeUhK2DalclZKH10AGDqnwI3ssyHTULg=";
  };

  buildInputs = [
    pythonPackages.aenum
    pythonPackages.pillow
    pythonPackages.deprecation
    pythonPackages.numpy
    poetry
    pythonPackages.poetry-core
  ];

  pythonImportsCheck = [
    "blendmodes"
  ];

  meta = with lib; {
    homepage = "https://github.com/FHPythonUtils/BlendModes";
    description = "Use this module to apply a number of blending modes to a background and foreground image";
    license = licenses.mit;
  };
}
