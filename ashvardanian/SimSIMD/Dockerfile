# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUTF8=1

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    gcc-12 \
    g++-12 \
    libjemalloc-dev \
    libomp-dev && \
    rm -rf /var/lib/apt/lists/*

# Update alternatives for gcc and g++
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 12 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 12 && \
    update-alternatives --config gcc && \
    update-alternatives --config g++

# Install Python dependencies
RUN pip install --no-cache-dir pip -U && \
    pip install --no-cache-dir py-cpuinfo pytest pytest-repeat numpy scipy tabulate

# Build the package
RUN python -m pip install .

# Define the command to run tests
CMD ["pytest", "scripts/test.py", "-s", "-x", "-Wd", "-v"]