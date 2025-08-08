# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV AX_ROOT=/axmol

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libx11-dev \
    automake \
    libtool \
    libxmu-dev \
    libglu1-mesa-dev \
    libgl2ps-dev \
    libxi-dev \
    libfontconfig1-dev \
    libgtk-3-dev \
    libwebkit2gtk-4.0-dev \
    binutils \
    g++ \
    libasound2-dev \
    libxxf86vm-dev \
    libvlc-dev \
    libvlccore-dev \
    vlc \
    unzip \
    curl \
    wget \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Install PowerShell
RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y powershell && \
    rm packages-microsoft-prod.deb

# Create working directory
WORKDIR ${AX_ROOT}

# Copy the axmol source code into the container
COPY . ${AX_ROOT}

# Setup axmol environment
RUN cd ${AX_ROOT} && \
    pwsh ./setup.ps1 -y

# Build the project
RUN cd ${AX_ROOT} && \
    mkdir build && \
    cd build && \
    cmake .. -DAX_BUILD_TESTS=ON && \
    make -j$(nproc)

# Set the default command to run unit tests
CMD ["bash", "-c", "cd ${AX_ROOT}/build/tests/unit-tests && ./unit-tests"]