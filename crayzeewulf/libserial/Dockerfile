# Use Ubuntu 18.04 as the base image, similar to existing Dockerfiles
FROM ubuntu:18.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install all necessary dependencies for building and testing
# This includes build tools, Boost for unit tests, Google Test, and Python dependencies
# We will manually install a newer version of CMake to meet GTest requirements
RUN apt-get -yq update && apt-get install -yq --no-install-recommends \
        build-essential \
        coreutils \
        doxygen \
        g++ \
        graphviz \
        libboost-test-dev \
        libgtest-dev \
        libpython-dev \
        python3-sip-dev \
        pkg-config \
        python3-sphinx \
        python3-sphinx-rtd-theme \
        git \
        autogen \
        autoconf \
        libtool \
        wget \
    && apt-get autoremove -y \
    && apt-get clean -y

# Manually install a newer version of CMake (3.13 or higher)
# This is required for the Google Test external project
RUN wget https://github.com/Kitware/CMake/releases/download/v3.13.5/cmake-3.13.5-Linux-x86_64.tar.gz \
    && tar -xzf cmake-3.13.5-Linux-x86_64.tar.gz -C /opt \
    && ln -s /opt/cmake-3.13.5-Linux-x86_64/bin/* /usr/local/bin \
    && rm cmake-3.13.5-Linux-x86_64.tar.gz

# Set the working directory inside the container
WORKDIR /usr/src/libserial

# Copy the entire source code into the container
COPY . .

# Build the library using the provided compile.sh script
# This script uses CMake to configure and build the project
RUN ./compile.sh

# Run unit tests after building
# The tests are located in the build/bin directory
# We use ctest for running the tests
CMD ["bash", "-c", "cd build && ctest -V"]