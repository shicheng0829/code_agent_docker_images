# Use Ubuntu as the base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
    g++ \
    cmake \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the source code
COPY . .

# Create build directory
RUN mkdir build

# Build the project
WORKDIR /app/build
RUN cmake .. -DSNITCH_DO_TEST=1
RUN cmake --build . --parallel 2

# Run tests
CMD ["cmake", "--build", ".", "--target", "snitch_runtime_tests_run"]