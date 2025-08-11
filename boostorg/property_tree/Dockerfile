# Dockerfile for Boost.PropertyTree development and testing
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the property_tree library
COPY . /app/property_tree

# Clone Boost superproject
RUN git clone --depth 1 -b develop https://github.com/boostorg/boost.git boost-root

# Set up the property_tree library in Boost
WORKDIR /app/boost-root
RUN cp -r /app/property_tree/* libs/property_tree/ \
    && git submodule update --init tools/boostdep \
    && python3 tools/boostdep/depinst/depinst.py -I examples property_tree \
    && ./bootstrap.sh \
    && ./b2 -d0 headers

# Build and run tests using CMake
WORKDIR /app/boost-root
RUN mkdir __build__ && cd __build__ \
    && cmake -DBOOST_INCLUDE_LIBRARIES=property_tree -DBUILD_TESTING=ON .. \
    && cmake --build . --target tests

# Set working directory for running tests
WORKDIR /app/boost-root/__build__

# Default command to run tests
CMD ["ctest", "--output-on-failure", "--no-tests=error"]