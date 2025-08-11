# Use Ubuntu 24.04 as the base image (matching the CI environment)
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHON_VERSION=3.13.5

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    cmake \
    git \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    llvm \
    make \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    python3-full \
    tk-dev \
    wget \
    xz-utils \
    zlib1g-dev \
    mcpp \
    libmcpp-dev \
    liblmdb-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash developer
USER developer
WORKDIR /home/developer

# Create a virtual environment and activate it
RUN python3 -m venv /home/developer/venv
ENV PATH="/home/developer/venv/bin:$PATH"

# Install Python dependencies in the virtual environment
RUN pip install --upgrade pip setuptools wheel
RUN pip install ruff pyright numpy

# Copy the project files
COPY --chown=developer:developer . /home/developer/ice

# Set working directory
WORKDIR /home/developer/ice

# Build the C++ components (needed for Python bindings)
RUN make -C cpp srcs

# Build the Python components
RUN make -C python

# Default command to run tests
CMD ["python3", "allTests.py"]