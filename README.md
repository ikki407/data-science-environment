Goal: easy environment for data science task.



## Build custom docker via gcr.io/kaggle-images/python


## Requirements

- Docker
- [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) (optional for GPU)

## How to use


First, [build docker](#Docker-build). After build completed, run containers.
```shell
docker run -v $PWD:/tmp/working -w=/tmp/working --rm -it my-kaggle-images/python-custom python code.py
```

Interactively run commands in bash.
```shell
docker run -v $PWD:/tmp/working -w=/tmp/working --rm -it my-kaggle-images/python-custom /bin/bash
```


If you build GPU images, use this command:
```shell
docker run -v $PWD:/tmp/working -w=/tmp/working --rm -it --runtime=nvidia my-kaggle-images/python-gpu-build-custom /bin/bash
```


## Docker build


### Build base image

```shell
docker build -t my-kaggle-images/python -f docker/base_kaggle/Dockerfile .
```
Image building takes long time (kaggle image include a lot of libraries!!), so have a coffee :coffee:.  
GPU image is still not provided, build it with [below commands](#Docker-build-from-source-codes).


### Build your own custom docker from base image

For specific tasks, you can add/remove any libraries, files, and data though updating the `Dockerfile.custom.*`.
```shell
# CPU
docker build -t my-kaggle-images/python-custom -f docker/custom_kaggle_cpu/Dockerfile.custom.cpu .
```
```shell
# GPU
docker build -t my-kaggle-images/python-gpu-build-custom -f docker/custom_kaggle_gpu/Dockerfile.custom.gpu .
```

### Tips

Put these lines in your `.bashrc` file for useful command.
```
kpython(){
  docker run -v $PWD:/tmp/working -w=/tmp/working --rm -it my-kaggle-images/python python "$@"  
}
ikpython() {
  docker run -v $PWD:/tmp/working -w=/tmp/working --rm -it my-kaggle-images/python ipython
}
kjupyter() {
  docker run -v $PWD:/tmp/working -w=/tmp/working -p 8888:8888 --rm -it my-kaggle-images/python jupyter notebook --no-browser --ip="0.0.0.0" --notebook-dir=/tmp/working --allow-root
}
```

Then, run the following commands:
```shell
kpython   # python on Docker (my-kaggle-images/python)
ikpython  # ipython on Docker (my-kaggle-images/python)
kjupyter  # jupyter on Docker (my-kaggle-images/python)
```


## Docker build from source codes
<details><summary>Details</summary><div>

You can get latest details in [github](https://github.com/Kaggle/docker-python).

### Submodule update

First building, submodule initialization is necessary.
```shell
git submodule update --init
```
Move directory to Kaggle/docker-python.
```shell
cd submodule/docker-python/
```


NOTE: we are using Kaggle/docker-gpu-python image of CUDA 9.2 version (commit hash: [a6ba32e](https://github.com/Kaggle/docker-python/commit/a6ba32e0bb017a30e079cf8bccab613cd4243a5f))  
If you want to use CUDA 10.0 or 10.1+, checkout the latest commit.


### Build

For CPU
```shell
./build --use-cache  # IMAGE TAG = kaggle/python-build
```

For GPU
```shell
./build --gpu --use-cache  # IMAGE TAG = kaggle/python-gpu-build
```

This build takes long time, have a cup of coffee or sleep.


### Test

```shell
./test  # --gpu
```


### Run

For CPU
```shell
# Run the image built locally:
docker run --rm -it kaggle/python-build /bin/bash
```

For GPU
```shell
# Run the image built locally (nvidia-docker2)
docker run --runtime nvidia --rm -it kaggle/python-gpu-build /bin/bash

# If you use old nvidia-docker, run following command
# nvidia-docker run --rm -it kaggle/python-gpu-build /bin/bash
```
To ensure your container can access the GPU, follow the instructions posted [here](https://github.com/Kaggle/docker-python/issues/361#issuecomment-448093930).
If you don't have the nvidia-docker, install the latest nvidia-docker [here](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-2.0)).


</div></details>
