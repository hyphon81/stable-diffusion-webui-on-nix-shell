{ lib, pythonPackages, python }:

python.pkgs.buildPythonPackage rec {
  pname = "ffmpy";
  version = "0.3.0";

  src = python.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-dXWRWB7uJbSlCsn/ubWANaJ5RTPbR+BRL1P7LXtvmtw=";
  };

  buildInputs = [
  ];

  pythonImportsCheck = [
    "ffmpy"
  ];

  meta = with lib; {
    homepage = "https://github.com/Ch00k/ffmpy";
    description = "Pythonic interface for FFmpeg/FFprobe command line";
    license = licenses.mit;
  };
}
