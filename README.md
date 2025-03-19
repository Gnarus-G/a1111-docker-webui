## SD-Webui, dockerized

Setup for my specs which include an AMD GPU: RX 6900XT

### Run

```sh
make clone_forge
```

```sh
make start REPO=forge
```

### Notes
You may have to add yourself to some groups
```sh
usermod -aG video $USER
usermod -aG render $USER
```

Update the Makefile to point to where your which directories hold models.

```make
MODELS_CHECKPOINTS=~/comfy/ComfyUI/models/checkpoints
MODELS_LORA=~/comfy/ComfyUI/models/loras
MODELS_VAE=~/comfy/ComfyUI/models/vae
```

## References

- https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Install-and-Run-on-AMD-GPUs#running-inside-docker
