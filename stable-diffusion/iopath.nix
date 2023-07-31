{ lib, fetchFromGitHub, pythonPackages, python }:

python.pkgs.buildPythonPackage rec {
  pname = "iopath";
  version = "0.1.9";

  src = fetchFromGitHub {
    owner = "facebookresearch";
    repo = "iopath";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-Qubf/mWKMgYz9IVoptMZrwy4lQKsNGgdqpJB1j/u5s8=";
  };

  propagatedBuildInputs = [
    pythonPackages.tqdm
    pythonPackages.portalocker
  ];

  pythonImportsCheck = [
    "iopath"
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/facebookresearch/iopath";
    description = "A python library that provides common I/O interface across different storage backends.";
    license = licenses.mit;
  };
}
