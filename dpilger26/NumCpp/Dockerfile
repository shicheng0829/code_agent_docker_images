# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    cmake \
    wget \
    git \
    software-properties-common \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda for ARM64 architecture
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh

# Set PATH to include conda
ENV PATH="/opt/conda/bin:${PATH}"

# Create conda environment from the provided environment.yml
COPY test/pytest/environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

# Activate the conda environment
SHELL ["conda", "run", "-n", "test", "/bin/bash", "-c"]

# Install additional system dependencies needed for the project
RUN apt-get update && apt-get install -y \
    libboost-all-dev \
    libtbb-dev \
    libgtest-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . .

# Build the project
RUN cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=17 -DBUILD_TESTS=ON -DBUILD_GTEST=ON && \
    cmake --build build --config Release -j$(nproc)

# Default command to run tests
CMD ["conda", "run", "-n", "test", "bash", "-c", "cd test/pytest && pytest -s"]