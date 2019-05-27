# Build new image from existing images
FROM kaggle/python-gpu-build

# Remove stubs of CUDA
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib64:/usr/local/cuda/lib64

# Install libraries in requirements.txt
COPY requirements.txt /tmp
RUN pip install --no-cache-dir -r /tmp/requirements.txt && \
    rm -rf /tmp/* /var/tmp/* ~/.cache/pip

# Add files from remote
#ADD https://github.com/microsoft/LightGBM/blob/master/README.md /tmp
