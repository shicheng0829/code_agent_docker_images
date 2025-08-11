# Use Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHON_VERSION=3.10

# Install necessary packages including development libraries
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        build-essential \
        cmake \
        zlib1g-dev \
        libjpeg-turbo8-dev \
        libpng-dev \
        libtiff-dev \
        libhdf5-dev \
        libfftw3-dev \
        libopenexr-dev \
        libboost-python-dev \
        python3-dev \
        python3-numpy-dev \
        doxygen \
        && \
    rm -rf /var/lib/apt/lists/*

# Install Miniforge for ARM64 architecture
RUN curl -fsSLo Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh" && \
    bash Miniforge3.sh -b -p /opt/conda && \
    rm Miniforge3.sh

# Set PATH to include conda
ENV PATH=/opt/conda/bin:$PATH

# Create conda environment with required packages
RUN conda config --show && \
    conda create \
        --quiet --yes \
        --override-channels \
        -c conda-forge -c nodefaults \
        --name vigra \
        python=${PYTHON_VERSION} pytest c-compiler cxx-compiler \
        zlib libjpeg-turbo libpng libtiff hdf5 fftw \
        libboost-python libboost-python-devel numpy h5py sphinx \
        openexr lemon cmake make ruff

# Activate the conda environment
SHELL ["conda", "run", "-n", "vigra", "/bin/bash", "-c"]

# Copy the source code into the container
COPY . /vigra

# Set the working directory
WORKDIR /vigra

# Build the project
RUN mkdir -p build && \
    cd build && \
    cmake .. \
        -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX \
        -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
        -DCMAKE_BUILD_TYPE=Release \
        -DPython_ROOT_DIR="$CONDA_PREFIX" \
        -DPython_FIND_VIRTUALENV=ONLY \
        -DTEST_VIGRANUMPY=ON \
        -DWITH_OPENEXR=ON \
        -DWITH_LEMON=ON \
        -DAUTOEXEC_TESTS=OFF \
        -DCMAKE_FIND_FRAMEWORK=LAST \
        -DCMAKE_FIND_APPBUNDLE=LAST \
        -DZLIB_INCLUDE_DIR=$CONDA_PREFIX/include \
        -DZLIB_LIBRARY=$CONDA_PREFIX/lib/libz.so \
        -DPNG_LIBRARY=$CONDA_PREFIX/lib/libpng.so \
        -DPNG_PNG_INCLUDE_DIR=$CONDA_PREFIX/include && \
    make -j2 && \
    make check -j2 && \
    ctest -V

# Default command to run tests
CMD ["conda", "run", "-n", "vigra", "bash", "-c", "cd build && ctest -V"]