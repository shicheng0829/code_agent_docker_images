# Use Ubuntu 20.04 as the base image, matching the CI environment
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TARGET_CPU=amd64
ENV BUILD_DOC=true

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    liblua5.2-dev \
    ragel \
    python3-pip \
    git && \
    # Clean up apt cache to reduce image size
    rm -rf /var/lib/apt/lists/*

# Install Python packages for documentation
RUN pip3 install sphinx sphinx_rtd_theme

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Clone dependencies
RUN git clone --depth 1 https://github.com/vovkos/axl && \
    git clone --depth 1 https://github.com/vovkos/graco && \
    git clone --depth 1 https://github.com/vovkos/luadoxyxml

# Build and test
CMD ["/bin/bash", "-c", "\
    mkdir axl/build && \
    cd axl/build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug && \
    make && \
    cd ../.. && \
    echo \"set (AXL_CMAKE_DIR $(pwd)/axl/cmake $(pwd)/axl/build/cmake)\" >> paths.cmake && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug && \
    make && \
    ctest --output-on-failure \
"]