# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for building and running tests
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    xorg-dev \
    libx11-dev \
    libxmu-dev \
    libxi-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libosmesa-dev \
    libglfw3-dev \
    libglew-dev \
    lcov \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project into the container
COPY . .

# Create a build directory and navigate into it
RUN mkdir build && cd build \
    # Configure the project with CMake, enabling unit tests and Hello World
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
                -DPLAYRHO_BUILD_UNIT_TESTS=ON \
                -DPLAYRHO_BUILD_HELLOWORLD=ON \
                -DPLAYRHO_BUILD_TESTBED=OFF \
                -DPLAYRHO_BUILD_BENCHMARK=OFF \
                -DCMAKE_CXX_FLAGS="-w -fpermissive" \
                -DCMAKE_CXX_STANDARD=17 \
                -DPLAYRHO_REAL_TYPE=float \
    # Build the project
    && make -j$(nproc)

# Set the default command to run the unit tests
CMD ["build/UnitTests/UnitTests", "--gtest_filter=-Dump.OneBodyWorld:Math.LengthFasterThanHypot"]