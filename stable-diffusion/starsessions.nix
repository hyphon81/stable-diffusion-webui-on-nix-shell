{ lib, pythonPackages, python }:

python.pkgs.buildPythonPackage rec {
  pname = "starsessions";
  version = "2.1.1";

  src = python.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-yyUN6E68YVmtGHyraeb+YOqxFoS0A0lFfnTc+3ZWyAU=";
  };

  buildInputs = [
    pythonPackages.itsdangerous
    pythonPackages.starlette
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/alex-oleshkevich/starsessions";
    description = "Advanced sessions for Starlette and FastAPI frameworks";
    license = licenses.mit;
  };
}
