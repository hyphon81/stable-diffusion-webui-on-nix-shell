{ lib, pythonPackages, python }:

python.pkgs.buildPythonPackage rec {
  pname = "fonts";
  version = "0.0.3";

  src = python.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-xiZlW3WmBxXhGOROJwZW/SL9j1QlKQH/br8TCK0BxAU=";
  };

  buildInputs = [

  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://pypi.org/project/fonts/";
    description = "A Python framework for distributing and managing fonts.";
  };
}
