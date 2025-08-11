# Use Ubuntu 22.04 as the base image, matching the CI workflow
FROM ubuntu:22.04

# Set environment variables to non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install dependencies required for building and testing
# These are based on the CI workflow and the getdeps.sh script
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    python3 \
    python3-pip \
    build-essential \
    libssl-dev \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libgtest-dev \
    libcurl4-openssl-dev \
    libpcap-dev \
    libbz2-dev \
    libzstd-dev \
    liblz4-dev \
    libsnappy-dev \
    libsodium-dev \
    libunwind-dev \
    libelf-dev \
    libdwarf-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /proxygen

# Copy the entire project into the container
COPY . .

# Build the project and run tests
# This mimics the CI workflow's build and test steps
RUN python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. proxygen --project-install-prefix proxygen:/usr/local \
    && python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. proxygen --project-install-prefix proxygen:/usr/local

# Default command (can be overridden)
CMD ["/bin/bash"]