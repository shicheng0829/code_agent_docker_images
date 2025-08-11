# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /app

# Install dependencies including newer CMake
RUN apt-get update && apt-get install -y \
    build-essential \
    ninja-build \
    git \
    python3 \
    wget \
    curl \
    libreadline-dev \
    zsh \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install newer CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update && \
    apt-get install -y cmake

# Create build directory
RUN mkdir -p /app/build

# Copy the source code (respecting .dockerignore)
COPY . /app

# Make scripts executable
RUN chmod +x /app/scripts/*.sh

# Run preparation script
RUN /app/scripts/preparation.linux.sh

# Default command
CMD ["/bin/bash"]