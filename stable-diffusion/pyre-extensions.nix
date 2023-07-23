{ lib, pythonPackages, python, torch }:

python.pkgs.buildPythonPackage rec {
  pname = "pyre_extensions";
  version = "0.0.29";

  src = python.pkgs.fetchPypi {
    inherit pname version format;
    dist = "py3";
    python = "py3";
    hash = "sha256-9P75CJhywGVvgt5+jzV68Dd9y7bC3q3Bp9MDeq9DdX4=";
  };

  format = "wheel";

  propagatedBuildInputs = [
    pythonPackages.typing-inspect
  ];

  meta = with lib; {
    homepage = "https://pyre-check.org";
    description = "Type system extensions for use with the pyre type checker";
    license = licenses.mit;
  };
}
