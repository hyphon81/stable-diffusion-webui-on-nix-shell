{ lib, stdenv, fetchurl, fetchgit, fetchFromGitHub,
  cudaPackages, pythonPackages, python, opencv,
  callPackage
}:

let
  tensorboard = pythonPackages.tensorboard.override {
    protobuf = pythonPackages.protobuf3;
    tensorboard-plugin-profile = pythonPackages.tensorboard-plugin-profile.override {
      protobuf = pythonPackages.protobuf3;
    };
    grpcio = pythonPackages.grpcio.override {
      protobuf = pythonPackages.protobuf3;
    };
  };

  ## torch version is old however it can run.
  torch = pythonPackages.torch.override {
    cudaSupport = true;
    protobuf = pythonPackages.protobuf3;
    tensorboard = tensorboard;
  };

  torchvision = pythonPackages.torchvision.override {
    torch = torch;
  };

  clip = pythonPackages.clip.override {
    torch = torch;
    torchvision = torchvision;
  };

  pytorch-lightning = pythonPackages.pytorch-lightning.overridePythonAttrs (old: rec {
    pname = "pytorch-lightning";
    version = "1.7.7";
    src = fetchFromGitHub {
      owner = "Lightning-AI";
      repo = "lightning";
      rev = "refs/tags/1.7.7";
      hash = "sha256-KMd7EQLxHowlxJi5nJD0d9bkBrSx+r1RgPy/SYUN8uU=";
    };

    propagatedBuildInputs = [
      pythonPackages.packaging
      pythonPackages.future
      pythonPackages.fsspec
      pythonPackages.pyyaml
      pythonPackages.tqdm
      pythonPackages.torchmetrics
      torch
      tensorboard
      pythonPackages.protobuf3
      lightning-cloud
      pythonPackages.deepdiff
      pythonPackages.croniter
      pythonPackages.traitlets
      starsessions
      pythonPackages.s3fs
    ];
  });

  transformers = pythonPackages.transformers.overridePythonAttrs (old: rec {
    pname = "transformers";
    version = "4.25.1";
    src = fetchFromGitHub {
      owner = "huggingface";
      repo = "transformers";
      rev = "refs/tags/v4.25.1";
      hash = "sha256-b0xEHM72HcaTRgGisB6fnPrMaXZ8EcJfowwK92W4aYg=";
    };

    propagatedBuildInputs = [
      pythonPackages.filelock
      huggingface_hub
      pythonPackages.numpy
      pythonPackages.protobuf3
      pythonPackages.packaging
      pythonPackages.pyyaml
      pythonPackages.regex
      pythonPackages.requests
      pythonPackages.tokenizers
      pythonPackages.tqdm
      torch
      tensorboard
    ];
  });

  huggingface_hub = pythonPackages.huggingface-hub.overridePythonAttrs (old: rec {
    version = "0.13.4";
    src = fetchFromGitHub {
      owner = "huggingface";
      repo = "huggingface_hub";
      rev = "refs/tags/v0.13.4";
      hash = "sha256-gauEwI923jUd3kTZpQ2VRlpHNudytz5k10n1yFo0Mm8=";
    };
  });

  fastapi = pythonPackages.fastapi.overridePythonAttrs (old: rec {
    pname = "fastapi";
    version = "0.90.1";
    src = fetchFromGitHub {
      owner = "tiangolo";
      repo = "fastapi";
      rev = "refs/tags/0.90.1";
      hash = "sha256-sLFd6CXOHvnmjqx2gOmuQGOBsfN6RLk1fLlCpkZ60uQ=";
    };

    
    propagatedBuildInputs = [
      starlette
      pythonPackages.pydantic
    ];

    doCheck = false;
  });

  starlette = pythonPackages.starlette.overridePythonAttrs (old: rec {
    pname = "starlette";
    version = "0.22.0";
    format = "pyproject";

    src = fetchFromGitHub {
      owner = "encode";
      repo = "starlette";
      rev = "refs/tags/0.22.0";
      hash = "sha256-vyGLNQMCWu3zGFF7jRuozVLCqwR1zWBWuYTIDRBncHk=";
    };

    nativeBuildInputs = [
      pythonPackages.hatchling
    ];

    patches = [ ];

    doCheck = false;
  });

  lightning-cloud = callPackage ./lightning-cloud.nix {
    pythonPackages = pythonPackages;
    python = python;
    fastapi = fastapi;
  };

  starsessions = callPackage ./starsessions.nix {
    pythonPackages = pythonPackages;
    python = python;
    starlette = starlette;
  };

  fonts = callPackage ./fonts.nix {
    pythonPackages = pythonPackages;
    python = python;
  };

  font-roboto = callPackage ./font-roboto.nix {
    pythonPackages = pythonPackages;
    python = python;
  };

  gfpgan = callPackage ./gfpgan.nix {
    pythonPackages = pythonPackages;
    python = python;
    opencv = opencv;
    torch = torch;
    torchvision = torchvision;
    tensorboard = tensorboard;
    basicsr = basicsr;
    facexlib = facexlib;
  };

  open_clip = callPackage ./open_clip.nix {
    pythonPackages = pythonPackages;
    python = python;
    torch = torch;
    torchvision = torchvision;
    huggingface_hub = huggingface_hub;
    timm = timm;
  };

  timm = callPackage ./timm.nix {
    pythonPackages = pythonPackages;
    python = python;
    torch = torch;
    torchvision = torchvision;
    tensorboard = tensorboard;
    huggingface_hub = huggingface_hub;
  };

  safetensors = callPackage ./safetensors.nix {
    pythonPackages = pythonPackages;
    python = python;
  };

  ## Not yet implemented 
  #xformers = callPackage ./xformers.nix {
  #  pythonPackages = pythonPackages;
  #  python = python;
  #  torch = torch;
  #  torchvision = torchvision;
  #};
  #
  #pyngrok = callPackage ./pyngrok.nix {
  #  pythonPackages = pythonPackages;
  #  python = python;
  #};

  lpips = callPackage ./lpips.nix {
    pythonPackages = pythonPackages;
    python = python;
    opencv = opencv;
    torch = torch;
    torchvision = torchvision;
  };

  blendmodes = callPackage ./blendmodes.nix {
    pythonPackages = pythonPackages;
    python = python;
  };

  accelerate = callPackage ./accelerate.nix {
    pythonPackages = pythonPackages;
    python = python;
    torch = torch;
    torchvision = torchvision;
  };

  basicsr = callPackage ./basicsr.nix {
    pythonPackages = pythonPackages;
    python = python;
    opencv = opencv;
    torch = torch;
    torchvision = torchvision;
    tensorboard = tensorboard;
  };

  facexlib = callPackage ./facexlib.nix {
    pythonPackages = pythonPackages;
    python = python;
    opencv = opencv;
    torch = torch;
    torchvision = torchvision;
  };

  gradio = callPackage ./gradio.nix {
    pythonPackages = pythonPackages;
    python = python;
    huggingface_hub = huggingface_hub;
    gradio-client = gradio-client;
    ffmpy = ffmpy;
    fastapi = fastapi;
  };

  gradio-client = callPackage ./gradio-client.nix {
    pythonPackages = pythonPackages;
    python = python;
    huggingface_hub = huggingface_hub;
  };

  ffmpy = callPackage ./ffmpy.nix {
    pythonPackages = pythonPackages;
    python = python;
  };

  realesrgan = callPackage ./realesrgan.nix {
    pythonPackages = pythonPackages;
    python = python;
    opencv = opencv;
    torch = torch;
    torchvision = torchvision;
    basicsr = basicsr;
    facexlib = facexlib;
    gfpgan = gfpgan;
  };

  clean-fid = callPackage ./clean-fid.nix {
    pythonPackages = pythonPackages;
    python = python;
    torch = torch;
    torchvision = torchvision;
  };

  resize-right = callPackage ./resize-right.nix {
    pythonPackages = pythonPackages;
    python = python;
    torch = torch;
  };

  torchdiffeq = callPackage ./torchdiffeq.nix {
    pythonPackages = pythonPackages;
    python = python;
    torch = torch;
  };

  kornia = callPackage ./kornia.nix {
    pythonPackages = pythonPackages;
    python = python;
    torch = torch;
  };

  torchsde = callPackage ./torchsde.nix {
    pythonPackages = pythonPackages;
    python = python;
    torch = torch;
    trampoline = trampoline;
  };

  trampoline = callPackage ./trampoline.nix {
    pythonPackages = pythonPackages;
    python = python;
  };

  invisible-watermark = callPackage ./invisible-watermark.nix {
    pythonPackages = pythonPackages;
    python = python;
    torch = torch;
    torchvision = torchvision;
    opencv = opencv;
  };

  stable-diffusion-ai = fetchgit {
    url = "https://github.com/Stability-AI/stablediffusion.git";
    rev = "cf1d67a6fd5ea1aa600c4df58e5b47da45f6bdbf";
    sha256 = "sha256-yEtrz/JTq53JDI4NZI26KsD8LAgiViwiNaB2i1CBs/I=";
  };

  taming-transformers = fetchgit {
    url = "https://github.com/CompVis/taming-transformers.git";
    rev = "24268930bf1dce879235a7fddd0b2355b84d7ea6";
    sha256 = "sha256-kDChiuNh/lYO4M1Vj7fW3130kNl5wh+Os4MPBcaw1tM=";
  };

  k-diffusion = fetchgit {
    url = "https://github.com/crowsonkb/k-diffusion.git";
    rev = "5b3af030dd83e0297272d861c19477735d0317ec";
    sha256 = "sha256-lnjYsMVjL6rVbWVvAjVQRcK3CSs2CGOEsN3nw6pS3rk=";
  };

  codeformer = fetchgit {
    url = "https://github.com/sczhou/CodeFormer.git";
    rev = "c5b4593074ba6214284d6acd5f1719b6c5d739af";
    sha256 = "sha256-JyyJe+VBeNK5rRaPJ4jYdKZqLnRfayHWkTwFNrSfseY=";
  };

  blip = fetchgit {
    url = "https://github.com/salesforce/BLIP.git";
    rev = "48211a1594f1321b00f14c9f7a5b4813144b2fb9";
    sha256 = "sha256-0IO+3M/Gy4VrNBFYYgZB2CzWhT3PTGBXNKPad61px5k=";
  };

  setuppy = ./setup.py;
in
  
#stdenv.mkDerivation rec {
pythonPackages.buildPythonApplication {
  name = "stable-diffusion-webui";
  src = fetchgit {
    url = "https://github.com/AUTOMATIC1111/stable-diffusion-webui.git";
    rev = "22bcc7be42";
    sha256 = "sha256-XVdPS9k9pTSX0Udo/rNkXK7eVkAREr3QAUOMJnOIm04=";
  };

  propagatedBuildInputs = [
    python
    cudaPackages.cudatoolkit
    cudaPackages.cudnn
    torch
    torchvision
    gfpgan
    clip
    open_clip
    timm
    #xformers
    #pyngrok
    lpips

    pythonPackages.rich
    pythonPackages.psutil
    torchsde
    pythonPackages.GitPython
    pythonPackages.inflection
    pythonPackages.lark
    kornia
    torchdiffeq
    resize-right
    clean-fid
    pythonPackages.jsonmerge
    pythonPackages.einops
    transformers
    pythonPackages.scikitimage
    pytorch-lightning
    realesrgan
    pythonPackages.pillow
    pythonPackages.piexif
    pythonPackages.requests
    pythonPackages.omegaconf
    pythonPackages.gdown

    gradio
    fonts
    font-roboto
    basicsr
    accelerate
    blendmodes

    facexlib
    pythonPackages.httpcore
    invisible-watermark
    opencv
    safetensors
    pythonPackages.aenum
    pythonPackages.deprecation
  ];

  preConfigure = ''
    cp ${setuppy} ./setup.py

    ## for searching with find_packages()
    touch scripts/__init__.py
    touch modules/__init__.py
    touch modules/api/__init__.py
    touch modules/codeformer/__init__.py
    touch modules/hypernetworks/__init__.py
    touch modules/models/__init__.py
    touch modules/models/diffusion/__init__.py
    touch modules/textual_inversion/__init__.py
    touch extensions-builtin/__init__.py
    touch extensions-builtin/LDSR/__init__.py
    touch extensions-builtin/LDSR/scripts/__init__.py
    touch extensions-builtin/Lora/__init__.py
    touch extensions-builtin/Lora/scripts/__init__.py
    touch extensions-builtin/ScuNET/__init__.py
    touch extensions-builtin/ScuNET/scripts/__init__.py
    touch extensions-builtin/SwinIR/__init__.py
    touch extensions-builtin/SwinIR/scripts/__init__.py

    ## launch.py is needed in lib
    mkdir -p $out/${pythonPackages.python.sitePackages}/
    cp launch.py $out/${pythonPackages.python.sitePackages}/

    ## launch.py into bin and supress git clone
    sed -i -e "1i #!${pythonPackages.python}/bin/python" launch.py
    substituteInPlace launch.py --replace "git_clone(" "#git_clone("
    substituteInPlace launch.py --replace "def #git_clone(" "def git_clone("

    ## requirements_version.txt is read when launch.py is running with no arg
    substituteInPlace requirements.txt --replace "opencv-contrib-python" "opencv";
    substituteInPlace requirements.txt --replace "pytorch_lightning==1.7.7" "lightning"
    cp requirements.txt $out/${pythonPackages.python.sitePackages}/requirements_versions.txt

    ## to fix js scripts path
    sed -i -e "265i\\            file_directories=[\"$out/${pythonPackages.python.sitePackages}\"],\\" webui.py
    sed -i -e "1759i\\    web_path = os.path.abspath(fn)\\" modules/ui.py

    ## put necessary *.js files
    mkdir $out/${pythonPackages.python.sitePackages}/extensions-builtin
    cp -r extensions-builtin/prompt-bracket-checker $out/${pythonPackages.python.sitePackages}/extensions-builtin/prompt-bracket-checker

    cp script.js $out/${pythonPackages.python.sitePackages}/script.js

    mkdir -p $out/${pythonPackages.python.sitePackages}/javascript
    cp -r javascript/* $out/${pythonPackages.python.sitePackages}/javascript/

    ## put *.yaml files
    mkdir -p $out/${pythonPackages.python.sitePackages}/configs
    cp -r configs/* $out/${pythonPackages.python.sitePackages}/configs/

    ## put html files
    mkdir -p $out/${pythonPackages.python.sitePackages}/html
    cp -r html/* $out/${pythonPackages.python.sitePackages}/html/

    ## put VAE-approx/model.pt
    mkdir -p $out/${pythonPackages.python.sitePackages}/models/VAE-approx
    cp models/VAE-approx/model.pt $out/${pythonPackages.python.sitePackages}/models/VAE-approx/model.pt

    ## put necessary repos
    mkdir -p $out/${pythonPackages.python.sitePackages}/repositories
    ln -s ${stable-diffusion-ai} $out/${pythonPackages.python.sitePackages}/repositories/stable-diffusion-stability-ai
    ln -s ${blip} $out/${pythonPackages.python.sitePackages}/repositories/BLIP
    ln -s ${codeformer} $out/${pythonPackages.python.sitePackages}/repositories/CodeFormer
    ln -s ${k-diffusion} $out/${pythonPackages.python.sitePackages}/repositories/k-diffusion
    ln -s ${taming-transformers} $out/${pythonPackages.python.sitePackages}/repositories/taming-transformers

  '';

  doCheck = false;
}
