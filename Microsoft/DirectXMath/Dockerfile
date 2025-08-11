# Use the official Ubuntu image as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    ninja-build \
    clang \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download and install CMake 3.20 or higher
RUN wget https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0-linux-aarch64.tar.gz && \
    tar -xzf cmake-3.20.0-linux-aarch64.tar.gz && \
    cp -r cmake-3.20.0-linux-aarch64/bin/* /usr/local/bin/ && \
    cp -r cmake-3.20.0-linux-aarch64/share/* /usr/local/share/ && \
    rm -rf cmake-3.20.0-linux-aarch64*

# Set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Clone the test repository
RUN git clone https://github.com/walbourn/directxmathtest.git Tests

# Create build directory
RUN mkdir -p out/build/x64-Debug

# Configure CMake for x64-Debug build with tests enabled
RUN cd out/build/x64-Debug && cmake -G "Ninja" -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON ../../..

# Build the project
RUN cd out/build/x64-Debug && cmake --build .

# Run the tests
CMD ["ctest", "--test-dir", "out/build/x64-Debug", "--output-on-failure"]