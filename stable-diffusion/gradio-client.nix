{ lib, pythonPackages, python, huggingface_hub }:

python.pkgs.buildPythonPackage rec {
  pname = "gradio-client";
  version = "0.2.10";
  format = "wheel";

  src = python.pkgs.fetchPypi {
    pname = "gradio_client";
    inherit version format;
    dist = "py3";
    python = "py3";
    hash = "sha256-ix4yCT92aBK5HGV1boWti75tYLiFuHtHkIpyNZyNcqA=";
  };

  propagatedBuildInputs = [
    huggingface_hub
    pythonPackages.fsspec
    pythonPackages.httpx
    pythonPackages.websockets
  ];

  meta = with lib; {
    homepage = "https://pypi.org/project/gradio-client/";
    description = "This directory contains the source code for gradio_client, a lightweight Python library that makes it very easy to use any Gradio app as an API.";
    license = licenses.asl20;
  };
}
