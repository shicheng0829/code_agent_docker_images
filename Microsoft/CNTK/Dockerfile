# CNTK Development Dockerfile
# Based on Ubuntu 20.04 for better compatibility with modern Python packages

FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Basic build tools
    build-essential \
    cmake \
    git \
    wget \
    curl \
    ca-certificates \
    unzip \
    bzip2 \
    sudo \
    lsb-release \
    # Development libraries
    libopenmpi-dev \
    openmpi-bin \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    zlib1g-dev \
    # For Python development
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    # For SWIG
    swig \
    # For Kaldi
    automake \
    libtool \
    autoconf \
    subversion \
    libapr1 \
    libaprutil1 \
    libltdl-dev \
    libltdl7 \
    libserf-1-1 \
    libsvn1 \
    m4 \
    # For Java bindings
    openjdk-8-jdk \
    # For graphics
    libgdiplus \
    # Cleanup
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip3 install --upgrade pip

# Set up user
RUN adduser --gecos "CNTK Developer" --disabled-password cntkuser && \
    usermod -a -G sudo cntkuser && \
    echo "cntkuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to cntkuser
USER cntkuser
WORKDIR /home/cntkuser

# Install Python packages
RUN pip3 install --user numpy scipy matplotlib jupyter pytest pytest-cov

# Clone CNTK repository
RUN git clone --depth=1 https://github.com/Microsoft/CNTK.git

# Set working directory
WORKDIR /home/cntkuser/CNTK

# Create build directory
RUN mkdir -p build/release

# Set up environment variables for building
ENV PYTHONPATH=/home/cntkuser/CNTK/bindings/python
ENV LD_LIBRARY_PATH=/home/cntkuser/CNTK/build/release/lib:/usr/lib:$LD_LIBRARY_PATH
ENV PATH=/home/cntkuser/.local/bin:$PATH

# Document how to build and test
# To build CNTK:
# cd build/release && \
# cmake ../.. -DCMAKE_BUILD_TYPE=Release -DPYTHON_PATH=/usr/bin/python3 && \
# make -j$(nproc)

# To run unit tests:
# cd build/release && \
# make unittests

# To run Python tests:
# python3 -m pytest Tests/EndToEndTests/CNTKv2Python/ModuleTests/

# Default command
CMD ["/bin/bash"]