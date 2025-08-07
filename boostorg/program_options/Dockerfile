# Use Ubuntu 20.04 as the base image, as seen in the CI configuration
FROM ubuntu:20.04

# Set environment variables to non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    g++ \
    python3 \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Clone the boost root repository
# Using develop branch as default, similar to CI
RUN git clone -b develop --depth 1 https://github.com/boostorg/boost.git boost-root

# Set working directory to boost-root
WORKDIR /app/boost-root

# Copy the current program_options library into the boost tree
# Assuming the Dockerfile is in the program_options root directory
COPY . /app/boost-root/libs/program_options

# Update submodules for boostdep
RUN git submodule update --init tools/boostdep

# Install dependencies for program_options using boostdep
RUN python3 tools/boostdep/depinst/depinst.py --git_args "--jobs 3" program_options

# Bootstrap boost build system
RUN ./bootstrap.sh

# Build boost headers
RUN ./b2 -d0 headers

# Run the unit tests for program_options
# This command is derived from the CI configuration
CMD ["./b2", "-j3", "libs/program_options/test", "toolset=gcc", "cxxstd=11,14,17,2a", "variant=debug,release"]