# SPDX-License-Identifier: BSD-3-Clause
# Copyright(c) 2024 Intel Corporation

# Use Ubuntu 22.04 as the base image, matching the CI environment
FROM ubuntu:22.04

# Set environment variables to non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for building and testing DPDK
# This list is based on the packages installed in the CI build workflow
RUN apt-get update && apt-get install -y \
    ccache \
    libarchive-dev \
    libbsd-dev \
    libbpf-dev \
    libfdt-dev \
    libibverbs-dev \
    libipsec-mb-dev \
    libisal-dev \
    libjansson-dev \
    libnuma-dev \
    libpcap-dev \
    libssl-dev \
    libvirt-dev \
    ninja-build \
    pkg-config \
    python3-pip \
    python3-pyelftools \
    python3-setuptools \
    python3-wheel \
    zlib1g-dev \
    # Additional packages for documentation generation
    doxygen \
    graphviz \
    man-db \
    python3-sphinx \
    python3-sphinx-rtd-theme \
    # Packages for testing
    babeltrace \
    gdb \
    jq \
    # Compiler
    gcc \
    clang \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /dpdk

# Copy the entire DPDK source code into the container
# This assumes the Dockerfile is in the root of the DPDK source directory
COPY . .

# Install Meson using pip
# Determine the minimum Meson version required by DPDK
# This script is part of the DPDK repository
RUN MESON_VERSION=$(python3 buildtools/get-min-meson-version.py) && \
    pip3 install "meson==$MESON_VERSION"

# Setup hugepages for testing (optional, as in CI)
# This is not strictly necessary for unit tests but mirrors the CI setup
RUN echo 1024 > /proc/sys/vm/nr_hugepages || true

# Default command to run the build and tests
# This uses the same script as the CI
CMD ["/bin/bash", "-c", ".ci/linux-setup.sh && .ci/linux-build.sh"]