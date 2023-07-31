{ lib, pkgs, callPackage, pythonPackages, python, cudaPackages,
  opencv, protobuf, ffmpeg_4-full
}:

let
  opencv-contrib-python = callPackage ./opencv-contrib-python.nix {
    python = python;
    pythonPackages = pythonPackages;
  };
in

python.pkgs.buildPythonPackage rec {
  pname = "mediapipe";
  version = "0.10.2";

  src = python.pkgs.fetchPypi {
    inherit pname version format;
    dist = "cp310";
    python = "cp310";
    abi = "cp310";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    hash = "sha256-5ijYtDUw64tB02FygzMF+L96YzGCBr28wEop+ew49Ug=";
  };
  format = "wheel";

  nativeBuildInputs = [
    opencv-contrib-python
  ];

  propagatedBuildInputs = [
    pythonPackages.absl-py
    pythonPackages.attrs
    pythonPackages.flatbuffers
    pythonPackages.matplotlib
    pythonPackages.numpy
    opencv
    protobuf
    pythonPackages.sounddevice
    pythonPackages.pybind11
    ffmpeg_4-full
  ];

  LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";

  pythonImportsCheck = [
    #"mediapipe"
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/google/mediapipe";
    description = "Cross-platform, customizable ML solutions for live and streaming media.";
    license = licenses.asl20;
  };
}
