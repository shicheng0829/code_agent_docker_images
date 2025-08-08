# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir pytest numpy

# Build the project
RUN cmake -B build_release -DCMAKE_BUILD_TYPE=Release -DSTRINGZILLA_BUILD_TEST=1 -DSTRINGZILLA_BUILD_BENCHMARK=OFF -DCMAKE_CXX_FLAGS="-Wno-error=uninitialized -Wno-error=maybe-uninitialized"
RUN cmake --build build_release --config Release

# Run tests
CMD ["python", "-m", "pytest", "scripts/test.py", "-v"]