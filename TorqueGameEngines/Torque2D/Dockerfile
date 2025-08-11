FROM ubuntu:20.04

# Set non-interactive frontend for apt
ARG DEBIAN_FRONTEND=noninteractive

# Install build dependencies and runtime libraries
RUN apt-get update && \
    apt-get -y install \
        build-essential \
        gcc-i686-linux-gnu \
        g++-i686-linux-gnu \
        nasm \
        libsdl1.2-dev \
        libxft-dev \
        libopenal-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

# Create build directory
RUN mkdir /torque2d-engine-build/

# Copy project files
COPY . /torque2d-engine-build/

# Set working directory
WORKDIR /torque2d-engine-build/engine/compilers/Make-32bit/

# Build the engine
RUN make -j$(nproc) CC=i686-linux-gnu-gcc LD=i686-linux-gnu-gcc debug

# Set working directory to project root
WORKDIR /torque2d-engine-build/

# Default command to run unit tests
CMD ["./Torque2D_DEBUG", "-script", "main.runAllUnitTests.cs"]