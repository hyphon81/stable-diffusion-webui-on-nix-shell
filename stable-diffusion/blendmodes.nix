{ lib, pythonPackages, python }:

python.pkgs.buildPythonPackage rec {
  pname = "blendmodes";
  version = "2022";

  src = python.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-k2jxwekOhzS0lo8MrANpbg5acU/VfnS8bu/SXAQY/QM=";
  };

  buildInputs = [
    pythonPackages.aenum
    pythonPackages.pillow
    pythonPackages.deprecation
    pythonPackages.numpy
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
