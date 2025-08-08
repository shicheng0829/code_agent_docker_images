# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Install system dependencies including CMake
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    clang \
    python3 \
    python3-pip \
    python3-venv \
    git \
    curl \
    sed \
    && rm -rf /var/lib/apt/lists/*

# Set up Python symlink
RUN ln -sf /usr/bin/python3 /usr/bin/python

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Remove the incompatible CMake policy line
RUN sed -i '/cmake_policy(SET CMP0135 NEW)/d' CMakeLists.txt

# Install Python dependencies
RUN pip install -r requirements.txt

# Build the project
RUN rm -fR build && \
    cmake -B build && \
    cmake --build build -j

# Default command to show build success
CMD ["echo", "Build completed successfully. Run 'ctest --test-dir build -j --output-on-failure' to execute tests."]