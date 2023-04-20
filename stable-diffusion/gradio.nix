{ lib, pythonPackages, python, huggingface_hub, gradio-client, ffmpy, fastapi }:

python.pkgs.buildPythonPackage rec {
  pname = "gradio";
  version = "3.23.0";

  src = python.pkgs.fetchPypi {
    inherit pname version format;
    dist = "py3";
    python = "py3";
    hash = "sha256-H2N/gOS3QIksPMXsVZFYr+K2uX8KGOyliMI13e3dx+w=";
  };

  format = "wheel";

  propagatedBuildInputs = [
    pythonPackages.aiofiles
    pythonPackages.aiohttp
    pythonPackages.matplotlib
    pythonPackages.mdit-py-plugins
    pythonPackages.semantic-version
    fastapi
    pythonPackages.orjson
    pythonPackages.websockets
    pythonPackages.pandas
    huggingface_hub
    pythonPackages.uvicorn
    gradio-client
    pythonPackages.httpx
    pythonPackages.pydub
    pythonPackages.altair
    ffmpy
  ];

  meta = with lib; {
    homepage = "https://gradio.app/";
    description = "Gradio is the fastest way to demo your machine learning model with a friendly web interface so that anyone can use it, anywhere!";
    license = licenses.asl20;
  };
}
