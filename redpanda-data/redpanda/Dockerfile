# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    wget \
    gnupg \
    lsb-release \
    software-properties-common \
    build-essential \
    clang \
    clang-tidy \
    cmake \
    libboost-all-dev \
    libc-ares-dev \
    libgssapi-krb5-2 \
    libkrb5-dev \
    liblz4-dev \
    libprotobuf-dev \
    libprotoc-dev \
    libre2-dev \
    libsctp-dev \
    libsnappy-dev \
    libssl-dev \
    libxxhash-dev \
    libyaml-cpp-dev \
    libzstd-dev \
    lld \
    ninja-build \
    openssl \
    protobuf-compiler \
    python3 \
    python3-jinja2 \
    python3-jsonschema \
    ragel \
    systemtap-sdt-dev \
    valgrind \
    xfslibs-dev \
    ccache \
    cargo \
    golang && \
    # Clean up
    rm -rf /var/lib/apt/lists/*

# Install Bazel using Bazelisk
RUN curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 -o /usr/local/bin/bazel && \
    chmod +x /usr/local/bin/bazel

# Set working directory
WORKDIR /redpanda

# Copy the source code
COPY . .

# Build Redpanda
RUN bazel build //src/v:redpanda

# Run unit tests
CMD ["bazel", "test", "//src/v/..."]