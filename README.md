Goal: easy environment for data science task.



## Build custom docker via gcr.io/kaggle-images/python

## How to use

First, [build docker](#Docker-build). After build completed, run containers.
```shell
docker run -v $PWD:/tmp/working -w=/tmp/working --rm -it my-kaggle-images/python-custom python code.py
```

Interactively run commands in bash.
```shell
docker run -v $PWD:/tmp/working -w=/tmp/working --rm -it my-kaggle-images/python-custom /bin/bash
```

If you put [these useful command](#Tips), the following run:
```shell
kpython   # python on Docker (my-kaggle-images/python)
ikpython  # ipython on Docker (my-kaggle-images/python)
kjupyter  # jupyter on Docker (my-kaggle-images/python)
```

## Docker build


### Build base image

```shell
docker build -t my-kaggle-images/python -f docker/base_kaggle/Dockerfile .
```
Image building takes long time (kaggle image include a lot of libraries!!), so have a coffee :coffee:.  
GPU image is still not provided, build it with [below commands](#Docker-build-from-source-codes).


### Build your own custom docker

For specific tasks, you can add/remove any libraries, files, and data though updating the `Dockerfile.custom.*`.
```shell
# CPU
docker build -t my-kaggle-images/python-custom -f docker/custom_kaggle_cpu/Dockerfile.custom.cpu .
```
```shell
# GPU
docker build -t kaggle/python-gpu-build-custom -f docker/custom_kaggle_gpu/Dockerfile.custom.gpu .
```

### Tips

Put these lines in your `.bashrc` file.
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


## Docker build from source codes
<details><summary>Details</summary><div>

You can get latest details in [github](https://github.com/Kaggle/docker-python).

### Git clone

```shell
git clone https://github.com/Kaggle/docker-python.git
```


### Build

For CPU
```shell
./build --use-cache
```

For GPU
```shell
./build --gpu --use-cache
```

This build takes long time, have a cup of coffee or sleep.


### Test

```shell
./build  # --gpu
```


### Run

For CPU
```shell
# Run the image built locally:
docker run --rm -it kaggle/python-build /bin/bash
```

For GPU
```shell
# Run the image built locally:
docker run --runtime nvidia --rm -it kaggle/python-gpu-build /bin/bash
```
To ensure your container can access the GPU, follow the instructions posted [here](https://github.com/Kaggle/docker-python/issues/361#issuecomment-448093930).
If you don't have the nvidia-docker, install the latest nvidia-docker [here](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-2.0)).


### Build your own custom docker

Run below code in top directory.
```shell
# CPU
docker build -t kaggle/python-build-custom -f Dockerfile.build.custom.cpu .
```
```shell
# GPU
docker build -t kaggle/python-gpu-build-custom -f Dockerfile.build.custom.gpu .
```
</div></details>
