{ lib, fetchFromGitHub, which, ninja, gcc11, cudaPackages,
  pythonPackages, python, torch, pyre-extensions
}:

let
  flash-attention = fetchFromGitHub {
    owner = "Dao-AILab";
    repo = "flash-attention";
    rev = "eff9fe6b80";
    sha256 = "sha256-pHZoZkWapvf74uGq5VuID5Is+J2U3kJHFuzvVwf4aI0=";
  };

  cutlass = fetchFromGitHub {
    owner = "NVIDIA";
    repo = "cutlass";
    rev = "66d9cddc83";
    sha256 = "sha256-P8A1NEcYp5o15dB+d0zzSLwVWv472txLY7zDMYb70o4=";
  };
in

python.pkgs.buildPythonPackage rec {
  pname = "xformers";
  version = "0.0.20";

  src = fetchFromGitHub {
    owner = "facebookresearch";
    repo = "xformers";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-/KUdj39YGwb53I7qAvu5ucDM58bqXz3RdaQkUd6H+WY=";
  };

  CUDA_HOME = "${cudaPackages.cudatoolkit}";
  PYTORCH_NVCC = "${cudaPackages.cudatoolkit}/bin/nvcc";
  TORCH_CUDA_ARCH_LIST = "3.5;3.7;5.0;5.2;5.3;6.0;6.1;6.2;7.0;7.2;7.5;8.0;8.6";

  setupPyBuildFlags = [
    "-L ${cudaPackages.cudatoolkit.lib}/lib"
  ];

  configurePhase = ''
    touch xformers/version.py
    echo "# noqa: C801\n" > xformers/version.py
    echo "__version__ = \"${version}\"" >> xformers/version.py

    cp -r ${flash-attention}/* third_party/flash-attention/
    cp -r ${cutlass}/* third_party/cutlass/
  '';

  propagatedBuildInputs = [
    torch
    pyre-extensions
    pythonPackages.numpy
  ];

  nativeBuildInputs = [
    # Too high cpu load average and used memory
    #ninja

    which
    gcc11
  ];

  pythonImportsCheck = [
    "xformers"
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/facebookresearch/xformers";
    description = "xFormers - Toolbox to Accelerate Research on Transformers";
    license = licenses.bsd3;
  };
}
