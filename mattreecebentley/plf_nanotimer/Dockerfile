# Development Dockerfile for plf::nanotimer
# This Dockerfile sets up an environment for building and testing the nanotimer library

FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install build tools and dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source files
COPY . .

# Compile the test
RUN g++ -o test_nanotimer test_nanotimer.cpp

# Document how to run tests
# To run tests: docker run --rm plf-nanotimer-test
# To enter container for development: docker run -it --rm plf-nanotimer-test bash

# Default command to run tests
CMD ["./test_nanotimer"]