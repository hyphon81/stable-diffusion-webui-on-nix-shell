{ lib, pythonPackages, python, fastapi }:

python.pkgs.buildPythonPackage rec {
  pname = "lightning_cloud";
  version = "0.5.0";

  src = python.pkgs.fetchPypi {
    inherit pname version format;
    dist = "py3";
    python = "py3";
    hash = "sha256-AKbREYZ1Qjcvd7EAgTxnrhWTW15G6YzjDwCZtMXMwXY=";
  };

  format = "wheel";

  propagatedBuildInputs = [
    pythonPackages.urllib3
    pythonPackages.websocket-client
    pythonPackages.requests
    pythonPackages.pyjwt
    pythonPackages.click
    fastapi
    pythonPackages.rich
    pythonPackages.uvicorn
    pythonPackages.ujson
    pythonPackages.orjson
    pythonPackages.websockets
    pythonPackages.uvloop
    pythonPackages.watchfiles
    pythonPackages.httptools
    pythonPackages.httpx
    pythonPackages.email-validator
    pythonPackages.python-dotenv
  ];

  meta = with lib; {
    homepage = "https://pypi.org/project/lightning-cloud/";
    description = "Lightning AI Command Line Interface";
    license = licenses.asl20;
  };
}
