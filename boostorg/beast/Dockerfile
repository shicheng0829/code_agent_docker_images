FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    libssl-dev \
    python3 \
    git \
    curl \
    xz-utils \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash developer
RUN echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER developer
WORKDIR /home/developer

# Clone Boost superproject
RUN git clone --depth 1 https://github.com/boostorg/boost.git boost-root
WORKDIR /home/developer/boost-root

# Copy Beast library into Boost
COPY --chown=developer:developer . /home/developer/boost-root/libs/beast

# Install Boost dependencies
RUN git submodule update --init tools/boostdep
RUN python3 tools/boostdep/depinst/depinst.py beast

# Bootstrap Boost
RUN ./bootstrap.sh

# Generate headers
RUN ./b2 -d0 headers

# Run tests
CMD ["./b2", "libs/beast/test", "toolset=gcc", "cxxstd=11,14,17", "variant=debug"]