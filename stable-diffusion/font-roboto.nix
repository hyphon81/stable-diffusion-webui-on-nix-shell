{ lib, pythonPackages, python }:

python.pkgs.buildPythonPackage rec {
  pname = "font-roboto";
  version = "0.0.1";

  src = python.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-i8kTa/RmCfuxOvR4MBZ5mxTiPdopSmF5EXHefqLsRX8=";
  };

  buildInputs = [
  ];

  meta = with lib; {
    homepage = "https://pypi.org/project/font-roboto/";
    description = "The Roboto family of fonts";
    license = licenses.asl20;
  };
}
