{ lib, cudaPackages, pythonPackages, python, torch, torchvision,
  tensorboard, huggingface_hub, grpc, protobuf3_20
}:

python.pkgs.buildPythonPackage rec {
  pname = "timm";
  version = "0.4.12";

  src = python.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-sUvnDb1FKLXKhlfPW8JnLHkYw9nr+//oD0eFtU6ISx4=";
  };

  propagatedBuildInputs = [
    torch
    torchvision
    huggingface_hub
  ];

  buidInputs = [
    pythonPackages.tensorflowWithCuda
  ];

  pythonImportsCheck = [
    "timm"
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/huggingface/pytorch-image-models";
    description = "PyTorch image models, scripts, pretrained weights -- ResNet, ResNeXT, EfficientNet, EfficientNetV2, NFNet, Vision Transformer, MixNet, MobileNet-V3/V2, RegNet, DPN, CSPNet, and more";
    license = licenses.asl20;
  };
}
