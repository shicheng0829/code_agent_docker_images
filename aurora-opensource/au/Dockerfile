# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    python3-pip \
    build-essential \
    openjdk-11-jdk \
    clang-11 \
    clang-14 \
    gcc-10 \
    g++-10 \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Bazel using the official installer
RUN curl -fsSL https://github.com/bazelbuild/bazel/releases/download/6.0.0/bazel-6.0.0-installer-linux-x86_64.sh -o bazel-installer.sh && \
    chmod +x bazel-installer.sh && \
    ./bazel-installer.sh && \
    rm bazel-installer.sh

# Create a non-root user
RUN useradd -m -s /bin/bash developer

# Set working directory
WORKDIR /home/developer/au

# Copy the project files
COPY --chown=developer:developer . .

# Switch to the non-root user
USER developer

# Set up the environment
ENV PATH="/home/developer/au/tools/bin:${PATH}"

# Initialize git repo and set safe directory
RUN git init && \
    git config --global user.email "developer@example.com" && \
    git config --global user.name "Developer" && \
    git config --global --add safe.directory /home/developer/au

# Default command to run core tests
CMD ["bazel", "test", "//au/...:all", "//compatibility/...:all"]