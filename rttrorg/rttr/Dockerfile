FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/rttr

# Copy source code
COPY . .

# Create build directory
RUN mkdir build

# Build the project
RUN cd build && cmake .. -G "Ninja" -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=OFF && ninja

# Run unit tests
CMD ["/usr/src/rttr/build/bin/unit_tests"]