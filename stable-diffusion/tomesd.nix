{ lib, fetchFromGitHub, pythonPackages, python, torch }:

python.pkgs.buildPythonPackage rec {
  pname = "tomesd";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "dbolya";
    repo = "tomesd";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-m9PHEfUJng2JkbU3gc6pQ9HJuIBHaKSw9BJRRwV3Upg=";
  };

  propagatedBuildInputs = [
    torch
  ];

  pythonImportsCheck = [
    "tomesd"
  ];

  meta = with lib; {
    homepage = "https://github.com/dbolya/tomesd";
    description = "Speed up Stable Diffusion with this one simple trick!";
    license = licenses.mit;
  };
}
