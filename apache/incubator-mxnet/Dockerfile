# -*- mode: dockerfile -*-
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# Dockerfile for Ubuntu based development environment.
# Based on ci/docker/Dockerfile.build.ubuntu

####################################################################################################
# Base image with common dependencies
####################################################################################################
FROM ubuntu:20.04 AS base

WORKDIR /work/deps

SHELL ["/bin/bash", "-c"]
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get clean && \
    apt-get update && \
    apt-get install -y \
        ## Utilities
        curl \
        zip \ 
        unzip \
        wget \
        pandoc \
        ## Development tools
        build-essential \
        ninja-build \
        git \
        protobuf-compiler \
        libprotobuf-dev \
        default-jdk \
        clang-6.0 \
        clang-format \
        python3-yaml \
        clang-10 \
        clang-tidy-10 \
        g++ \ 
        g++-7 \
        g++-8 \
        libomp-dev \
        ## Dependencies
        libgomp1 \
        libturbojpeg0-dev \
        libcurl4-openssl-dev \
        libatlas-base-dev \
        libzmq3-dev \
        libopencv-dev \
        libxml2-dev \
        # BytePS
        numactl \
        libnuma-dev \
        ## Frontend languages
        # Python
        python3 \
        python3-pip \
        ## Documentation
        doxygen \
        pandoc \
        ## Build-dependencies for ccache 3.7.9
        autoconf \
        gperf \
        libb2-dev \
        libzstd-dev \
        gfortran && \
    rm -rf /var/lib/apt/lists/*

# Build OpenBLAS from source
RUN export LIBRARY_PATH=$LIBRARY_PATH:/usr/lib/gcc/x86_64-linux-gnu/7/ && \
    mkdir ~/openblas && \
    cd ~/openblas && \
    OPENBLAS_VERSION=0.3.10 && \
    wget \
        https://github.com/xianyi/OpenBLAS/archive/v${OPENBLAS_VERSION}.zip \
        -O openblas.zip && \
    unzip -q openblas.zip -d . && \
    cd OpenBLAS-${OPENBLAS_VERSION} && \
    CXX="clang++-6.0 -fPIC" CC="clang-6.0 -fPIC" make -j DYNAMIC_ARCH=1 DYNAMIC_OLDER=1 \
        USE_OPENMP=0 INTERFACE64=1 BINARY=64 && \
    make PREFIX=/usr/local/openblas-clang install && \
    cd .. && \
    rm -rf OpenBLAS-${OPENBLAS_VERSION} && \
    unzip -q openblas.zip -d . && \
    cd OpenBLAS-${OPENBLAS_VERSION} && \
    CXX="g++ -fPIC" CC="gcc -fPIC" make -j DYNAMIC_ARCH=1 DYNAMIC_OLDER=1 \
        USE_OPENMP=1 INTERFACE64=1 BINARY=64 && \
    make PREFIX=/usr/local install

# ccache 3.7.9 has fixes for caching nvcc outputs
RUN cd /usr/local/src && \
    git clone --recursive https://github.com/ccache/ccache.git && \
    cd ccache && \
    git checkout v3.7.9 && \
    ./autogen.sh && \
    ./configure --disable-man && \
    make -j$(nproc) && \
    make install && \
    cd /usr/local/src && \
    rm -rf ccache

# RAT License Checker tool
RUN cd /usr/local/src && \
    wget https://archive.apache.org/dist/creadur/apache-rat-0.13/apache-rat-0.13-bin.tar.gz && \
    tar xf apache-rat-0.13-bin.tar.gz

# Python & cmake
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install cmake==3.16.6 && \
    python3 -m pip install numpy>=1.17 requests>=2.20.0,<3 graphviz<0.9.0,>=0.8.1 contextvars;python_version<"3.7"

ARG USER_ID=0
COPY ci/docker/install/docker_filepermissions.sh /work/
RUN /work/docker_filepermissions.sh

ENV PYTHONPATH=./python/
WORKDIR /work/mxnet

COPY ci/docker/runtime_functions.sh /work/

####################################################################################################
# Development image with source code and build directory
####################################################################################################
FROM base AS dev

# Copy the source code
COPY . /work/mxnet

# Create build directory
RUN mkdir -p /work/build

# Set environment variables for development
ENV PYTHONPATH=/work/mxnet/python
ENV MXNET_LIBRARY_PATH=/work/build/libmxnet.so

####################################################################################################
# Test image with built library and installed Python package
####################################################################################################
FROM dev AS test

# Build the MXNet library
RUN cd /work/build && \
    CXXFLAGS="-Wno-error=strict-overflow" CC=gcc-7 CXX=g++-7 cmake \
        -DCMAKE_BUILD_TYPE="RelWithDebInfo" \
        -DENABLE_TESTCOVERAGE=ON \
        -DUSE_TVM_OP=ON \
        -DUSE_BLAS=Open \
        -DUSE_ONEDNN=OFF \
        -DUSE_CUDA=OFF \
        -DUSE_DIST_KVSTORE=ON \
        -DBUILD_CYTHON_MODULES=ON \
        -DBUILD_EXTENSION_PATH=/work/mxnet/example/extensions/lib_external_ops \
        -G Ninja /work/mxnet && \
    ninja -j$(($(nproc)/2))

# Install the Python package in development mode
RUN cd /work/mxnet/python && \
    pip3 install -e .

# Command to run tests
CMD ["bash", "-c", "cd /work/mxnet && python3 -m pytest -m 'not serial' -k 'not test_operator' -n 4 --durations=50 --verbose tests/python/unittest"]