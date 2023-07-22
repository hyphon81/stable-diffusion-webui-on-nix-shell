{ lib, pythonPackages, python, huggingface_hub, gradio-client, ffmpy, fastapi,
  fetchFromGitHub
}:

python.pkgs.buildPythonPackage rec {
  pname = "gradio";
  version = "3.32.0";

  src = python.pkgs.fetchPypi {
    inherit pname version format;
    dist = "py3";
    python = "py3";
    hash = "sha256-aNLr+tyrsKCI6QMo/N4Y28BjI3oJLzpBSi3v4rZ08Q8=";
  };

  format = "wheel";

  propagatedBuildInputs = [
    pythonPackages.aiofiles
    pythonPackages.aiohttp
    pythonPackages.matplotlib
    (pythonPackages.mdit-py-plugins.overridePythonAttrs (old: rec {
      src = fetchFromGitHub {
        owner = "executablebooks";
        repo = "mdit-py-plugins";
        rev = "refs/tags/v0.3.3";
        hash = "sha256-9eaVM5KxrMY5q0c2KWmctCHyPGmEGGNa9B3LoRL/mcI=";
      };
    }))
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
    pythonPackages.linkify-it-py
    ffmpy
  ];

  meta = with lib; {
    homepage = "https://gradio.app/";
    description = "Gradio is the fastest way to demo your machine learning model with a friendly web interface so that anyone can use it, anywhere!";
    license = licenses.asl20;
  };
}
