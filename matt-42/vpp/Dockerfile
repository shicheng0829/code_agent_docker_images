FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    g++ \
    libboost-dev \
    libopencv-dev \
    libeigen3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set compiler
ENV COMPILER=g++
ENV CXX=${COMPILER}

# Set working directory
WORKDIR /app

# Copy the source code
COPY . /app

# Clone and install iod library
RUN git clone https://github.com/matt-42/iod \
    && cd iod \
    && mkdir -p ~/local \
    && mkdir build && cd build \
    && cmake .. -DCMAKE_INSTALL_PREFIX=~/local \
    && make -j4 install

# Build VPP
RUN mkdir -p build && cd build \
    && cmake .. -DIOD_INCLUDE_DIR=~/local/include \
    && make -j4

# Default command to run tests
CMD ["bash", "-c", "cd build/tests && ctest --output-on-failure"]