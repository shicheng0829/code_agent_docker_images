# Use Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV build_type="Release"
ENV cc="gcc"
ENV cxx="g++"

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        nasm \
        libogg-dev \
        libxft-dev \
        libx11-dev \
        libxxf86vm-dev \
        libopenal-dev \
        libasound2-dev \
        libpipewire-0.3-dev \
        portaudio19-dev \
        oss4-dev \
        libjack-dev \
        libpulse-dev \
        libdbus-1-dev \
        libfreetype6-dev \
        libxcursor-dev \
        libxinerama-dev \
        libxi-dev \
        libxrandr-dev \
        libxss-dev \
        libglu1-mesa-dev \
        libgtk-3-dev \
        ninja-build \
        cmake \
        git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Patch the types.gcc.h file to support ARM64
RUN sed -i 's/#elif defined(__aarch64__)/#elif defined(__aarch64__) || defined(__ARM64__)/' Engine/source/platform/types.gcc.h

# Configure, build, and install
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=${build_type} -DTORQUE_APP_NAME=Torque3D -DTORQUE_TESTING=ON && \
    cmake --build build --config ${build_type} --target install

# Run unit tests
CMD ["sh", "-c", "cd \"My Projects/Torque3D/game\" && ./Torque3D runTests.tscript"]