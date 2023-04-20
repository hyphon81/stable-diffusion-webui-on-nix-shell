{ lib, fetchFromGitHub, pythonPackages, python, torch, torchvision,
  huggingface_hub, timm
}:

python.pkgs.buildPythonPackage rec {
  pname = "open_clip";
  version = "2.17.1";

  src = fetchFromGitHub {
    owner = "mlfoundations";
    repo = "open_clip";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-Up66l9ItKb4iwlpYlgfvmUCXS7p2xu9GEGY8cvfM6Qs=";
  };

  propagatedBuildInputs = [
    torch
    torchvision
    pythonPackages.regex
    pythonPackages.ftfy
    pythonPackages.tqdm
    huggingface_hub
    pythonPackages.sentencepiece
    pythonPackages.protobuf3
    timm
  ];

  pythonImportsCheck = [
    "open_clip"
  ];

  meta = with lib; {
    homepage = "https://github.com/mlfoundations/open_clip";
    description = "An open source implementation of CLIP.";
  };
}
