FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libfltk1.3-dev \
    libjpeg-dev \
    libpng-dev \
    libglu1-mesa-dev \
    libltdl-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Build the project
RUN mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=RELEASE -DBUILD_PLAYER_PLUGIN=OFF -DCMAKE_INSTALL_PREFIX=$(pwd)/install .. && \
    make && \
    make install

# Set library path
ENV LD_LIBRARY_PATH=/app/build/install/lib

# Test the installation by showing help information
CMD ["/app/build/install/bin/stage", "-?"]