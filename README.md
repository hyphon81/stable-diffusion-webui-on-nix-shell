# About
This code is for building [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) in nix store with nix-shell command.

However, it was only attempted on "nix-channel nixos-23.05"(platform=nixos linux x86_64).

# How to use

- Building with nix-shell
```bash
# ls
localizations  shell.nix  stable-diffusion
# nix-shell
...build in /nix/store/...
```

- Put models for stable-diffusion in models/Stable-diffusion/
```bash
# mkdir -p models/Stable-diffusion
# (Put models in there)
```

- launch stable-diffusion-webui
```bash
# launch.py --data-dir=./ --localizations-dir=./localizations --skip-install
```

- launch via network
```bash
# launch.py --data-dir=./ --localizations-dir=./localizations --skip-install --listen
```

# Caution
This code was left because it worked about generating images.
It is not attempted some functions on stable-diffusion-webui.

- Known Issues
-- When launch via network, it caused error to open directory on server with webui.
