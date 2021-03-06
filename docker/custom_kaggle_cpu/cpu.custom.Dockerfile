# Build new image from existing images
FROM my-kaggle-images/python

# Install libraries in requirements.txt
COPY requirements.txt /tmp
RUN pip install --no-cache-dir -r /tmp/requirements.txt && \
    rm -rf /tmp/* /var/tmp/* ~/.cache/pip

# Add files from remote
#ADD https://github.com/microsoft/LightGBM/blob/master/README.md /tmp
