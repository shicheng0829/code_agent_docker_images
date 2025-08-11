# Development Dockerfile for TQUIC
# This Dockerfile sets up an environment for building and testing TQUIC

FROM rust:1.74

# Install build dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    clang \
    libclang-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /usr/src/tquic

# Clone the repository with submodules
RUN git clone --recurse-submodules https://github.com/tencent/tquic.git .

# Build the project with all features
RUN cargo build --all --all-features

# Default command runs tests
CMD ["cargo", "test", "--verbose"]