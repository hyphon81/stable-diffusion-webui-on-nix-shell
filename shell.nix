{ pkgs ? import <nixpkgs> {} }:
let
  opencv = pkgs.opencv4.override {
    enableGtk2 = true;
    enableCuda = true;
    cudaPackages= cudaPackages;
    enablePython = true;
    pythonPackages = pythonPackages;
  };

  cudaPackages = pkgs.cudaPackages;

  pythonPackages = pkgs.python3Packages;

  python = pythonPackages.python.withPackages(ps: with ps; [
    opencv
    pip
  ]);

  stable-diffusion-webui = pkgs.callPackage ./stable-diffusion/stable-diffusion-webui.nix {
      pythonPackages = pythonPackages;
      python = python;
      cudaPackages = cudaPackages;
      opencv = opencv;
  };
in
  pkgs.mkShell {
    name = "stable-diffusion-devenv";

    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";

    propagatedBuildInputs = with pkgs; [
      git
      python
      opencv
      cudaPackages.cudatoolkit
      cudaPackages.cudnn
      stable-diffusion-webui
    ];
}
