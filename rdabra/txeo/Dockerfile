# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TensorFlow_ROOT_DIR=/opt/tensorflow
ENV Protobuf_ROOT_DIR=/opt/protobuf
ENV LD_LIBRARY_PATH=/opt/tensorflow/lib:/opt/protobuf/lib

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    git \
    ninja-build \
    libgtest-dev \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Download and install newer CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.25.3/cmake-3.25.3-linux-x86_64.tar.gz && \
    tar -xzf cmake-3.25.3-linux-x86_64.tar.gz -C /opt/ && \
    rm cmake-3.25.3-linux-x86_64.tar.gz

# Update PATH to include newer CMake
ENV PATH=/opt/cmake-3.25.3-linux-x86_64/bin:$PATH

# Download and install Protobuf
RUN wget https://github.com/rdabra/txeo/releases/download/v1.0.0/libprotobuf-3.21.9-linux-x64.tar.gz && \
    tar -xzf libprotobuf-3.21.9-linux-x64.tar.gz -C /opt/ && \
    rm libprotobuf-3.21.9-linux-x64.tar.gz

# Download and install TensorFlow
RUN wget https://github.com/rdabra/txeo/releases/download/v1.0.0/libtensorflow-2.18-linux-x64-cpu.tar.gz && \
    tar -xzf libtensorflow-2.18-linux-x64-cpu.tar.gz -C /opt/ && \
    rm libtensorflow-2.18-linux-x64-cpu.tar.gz

# Build and install GTest
RUN cd /usr/src/gtest && \
    cmake CMakeLists.txt && \
    make && \
    cp lib/*.a /usr/lib/

# Create working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the project with tests enabled
RUN mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=ON && \
    make -j$(nproc)

# Default command to run tests
CMD ["bash", "-c", "cd build && ctest --output-on-failure"]