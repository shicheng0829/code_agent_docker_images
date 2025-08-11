# Use an official Ubuntu runtime as a parent image
FROM ubuntu:22.04

# Set environment variables to non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /usr/src/mimalloc

# Copy the current directory contents into the container at /usr/src/mimalloc
COPY . .

# Create build directory
RUN mkdir -p out/debug

# Build mimalloc debug
WORKDIR /usr/src/mimalloc/out/debug
RUN cmake ../.. -DCMAKE_BUILD_TYPE=Debug -DMI_DEBUG_FULL=ON
RUN make -j$(nproc)

# Run tests
CMD ["ctest", "--verbose", "--timeout", "240"]