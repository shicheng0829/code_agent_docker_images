FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    linux-headers-generic \
    libnuma-dev \
    libgmp-dev \
    libpcap-dev \
    git \
    wget \
    curl \
    vim \
    bc \
    pkg-config \
    libpcre3-dev \
    libssl-dev \
    libelf-dev \
    libdw-dev \
    libz-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/mtcp

# Copy the source code into the container
COPY . .

# Build and test
RUN bash .buildtest_dpdk.sh

# Default command
CMD ["bash"]