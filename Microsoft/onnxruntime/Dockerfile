# --------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
# --------------------------------------------------------------
# Dockerfile for ONNX Runtime Development Environment
# This Dockerfile creates an environment for developing and testing ONNX Runtime

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install common packages for development
RUN apt-get update \
    && apt-get -y install build-essential cppcheck valgrind clang lldb llvm gdb \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install additional OS packages required for building and testing
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    python3-dev \
    python3 \
    ca-certificates \
    python3-numpy \
    python3-setuptools \
    python3-wheel \
    python3-pip \
    g++ \
    gcc \
    ninja-build \
    git \
    wget \
    curl \
    tar \
    unzip \
    zlib1g-dev \
    libssl-dev \
    make \
    cmake \
    graphviz \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip3 install --upgrade pip

# Install Python dependencies for building and testing
RUN pip3 install numpy==2.2.6 mypy pytest setuptools>=68.2.2 wheel onnx==1.18.0 protobuf==4.25.1 sympy==1.14 flatbuffers psutil onnxscript==0.3.2 jinja2 markupsafe

# Create a non-root user
ARG BUILD_USER=onnxruntimedev
ARG BUILD_UID=1000
RUN adduser --uid $BUILD_UID $BUILD_USER

# Set up the working directory
WORKDIR /home/$BUILD_USER

# Copy the source code
COPY . /home/$BUILD_USER/onnxruntime
RUN chown -R $BUILD_USER:$BUILD_USER /home/$BUILD_USER/onnxruntime

# Switch to the non-root user
USER $BUILD_USER

# Set the working directory to the source code
WORKDIR /home/$BUILD_USER/onnxruntime

# Default command
CMD ["/bin/bash"]