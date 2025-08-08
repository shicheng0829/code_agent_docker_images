# Use Ubuntu 22.04 as the base image, matching the primary CI environment
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for building and testing
RUN apt-get update && apt-get install -y \
    curl \
    gcc \
    clang \
    pkg-config \
    libssl-dev \
    libudev-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Rust using rustup
# Use the oldest supported version according to README.md and CI config
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.75.0

RUN set -eux; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME;

# Set the working directory
WORKDIR /usr/src/sccache

# Copy the source code
COPY . .

# Run tests, excluding the test that requires special permissions
CMD ["cargo", "test", "--locked", "--all-targets", "--", "test_run_log_no_perm"]