CONTAINER_NAME=sdwebui
REPO = forge
MOUNT = `pwd`/$(REPO)
MODELS_DIR=`pwd`/models

build: Dockerfile
	docker build -t a1111:$(REPO) -f Dockerfile `pwd`

start:
	docker start -a $(CONTAINER_NAME)

stop:
	docker container stop $(CONTAINER_NAME)

setup: build
	docker run -it --network=host \
		--device=/dev/kfd \
		--device=/dev/dri \
		--group-add=video \
		--ipc=host \
		--cap-add=SYS_PTRACE \
		--security-opt seccomp=unconfined \
		-v $(MOUNT):/a1111 \
		-v $(MODELS_DIR):/a1111/models \
		--rm --name $(CONTAINER_NAME) \
		a1111:$(REPO)

ensure_host_mount_dir:
	mkdir -p $(MOUNT)
	chown -v :docker $(MOUNT)
	chmod -v g+w $(MOUNT)

clone_origin: override REPO = origin
clone_origin: build ensure_host_mount_dir
	docker run -v $(MOUNT):/a1111 a1111:$(REPO) \
		git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui .

clone_forge: override REPO = forge
clone_forge: build ensure_host_mount_dir
	docker run -v $(MOUNT):/a1111 a1111:$(REPO) \
		git clone https://github.com/lllyasviel/stable-diffusion-webui-forge.git .

clean:
	rm -rf origin forge
