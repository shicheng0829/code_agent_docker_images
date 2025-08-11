# syntax=docker/dockerfile:1

# Select base image
FROM ubuntu:24.04

# Disable prompt during packages installation
ARG DEBIAN_FRONTEND=noninteractive

# Minimize the number of layers (RUN, COPY and ADD create layers)
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#minimize-the-number-of-layers
# Install additional packages
RUN apt update && apt install -y \
  clang \
  clang-format-18 \
  clang-tidy-18 \
  cmake \
  g++ \
  git \
  libacl1-dev \
  libncurses5-dev \
  && rm -rf /var/lib/apt/lists/* \
  && apt clean \
  && useradd iox_roudi_test1 \
  && useradd iox_roudi_test2 \
  && useradd iox_roudi_test3

# Create a non-root user
RUN useradd -ms /bin/bash developer

# Set working directory
WORKDIR /iceoryx

# Copy the source code
COPY . .

# Change ownership of the copied files to the developer user
RUN chown -R developer:developer /iceoryx

# Switch to the non-root user
USER developer

# Set environment variables
ENV CC=clang
ENV CXX=clang++

# Create build directory
RUN mkdir -p build

# Build the project with tests enabled
RUN cd build && \
  cmake -DCMAKE_BUILD_TYPE=Debug \
        -DCMAKE_INSTALL_PREFIX=/iceoryx/install \
        -DBUILD_TEST=ON \
        -DBINDING_C=ON \
        -DINTROSPECTION=ON \
        -DEXAMPLES=ON \
        -DTOML_CONFIG=ON \
        ../iceoryx_meta && \
  cmake --build . --target install -- -j$(nproc)

# Document how to run tests
CMD ["bash", "-c", "cd build && ../tools/run_tests.sh all"]