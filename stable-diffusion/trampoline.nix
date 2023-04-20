{ lib, pythonPackages, python }:

python.pkgs.buildPythonPackage rec {
  pname = "trampoline";
  version = "0.1.2";
  format = "wheel";

  src = python.pkgs.fetchPypi {
    inherit pname version format;
    dist = "py3";
    python = "py3";
    hash = "sha256-NsyaT/mBGEPRd/wOB0DvvX2jnq3+blDJ4pN8vAbYmdk=";
  };

  buildInputs = [
  ];

  pythonImportsCheck = [
    "trampoline"
  ];

  meta = with lib; {
    homepage = "https://gitlab.com/ferreum/trampoline";
    description = "Simple and tiny yield-based trampoline implementation for python.";
    license = licenses.mit;
  };
}
