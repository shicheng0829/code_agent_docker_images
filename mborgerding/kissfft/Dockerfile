# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    libfftw3-dev \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install numpy

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Make the test script executable
RUN chmod +x test/kissfft-testsuite.sh

# Default command to run tests
CMD ["./test/kissfft-testsuite.sh"]