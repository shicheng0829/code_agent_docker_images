FROM ubuntu:14.04

# Set environment variables
ENV NUM_THREADS=4
ENV WITH_CMAKE=false
ENV WITH_PYTHON3=false
ENV WITH_IO=true
ENV WITH_CUDA=false
ENV WITH_CUDNN=false

# Install dependencies
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        graphviz \
        libboost-filesystem-dev \
        libboost-python-dev \
        libboost-system-dev \
        libboost-thread-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libatlas-base-dev \
        libatlas-dev \
        python-virtualenv \
        wget \
        libprotobuf-dev \
        protobuf-compiler \
        python-dev \
        python-numpy \
        python-protobuf \
        python-pydot \
        python-skimage \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libsnappy-dev \
        cmake \
        python-pip && \
    rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /workspace

# Copy the source code
COPY . /workspace

# Install Python packages using system pip
RUN pip install protobuf && \
    pip install pydot

# Configure the project
RUN cp Makefile.config.example Makefile.config && \
    echo "BLAS := atlas" >> Makefile.config && \
    echo "WITH_PYTHON_LAYER := 1" >> Makefile.config && \
    echo "CPU_ONLY := 1" >> Makefile.config

# Build the project
RUN make --jobs $NUM_THREADS all test pycaffe warn

# Run linting
RUN make lint

# Default command
CMD ["/bin/bash"]