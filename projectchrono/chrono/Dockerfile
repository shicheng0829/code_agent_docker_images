# Use Ubuntu 22.04 as the base image (matching the CI configuration)
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PROJECT_DIR=/chrono

# Install dependencies required for building and testing
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        # Basic build tools
        build-essential \
        cmake \
        ninja-build \
        git \
        # Testing dependencies
        libgtest-dev \
        # Chrono dependencies
        libirrlicht-dev \
        libeigen3-dev \
        swig \
        libxxf86vm-dev \
        freeglut3-dev \
        python3-dev \
        python3-numpy \
        python3-pip \
        libglu1-mesa-dev \
        libglew-dev \
        libglfw3-dev \
        libblas-dev \
        liblapack-dev \
        wget \
        xorg-dev \
        # Additional utilities
        vim \
        curl && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create project directory
WORKDIR ${PROJECT_DIR}

# Copy the source code
COPY . .

# Initialize and update git submodules to get Google Test and other dependencies
RUN git submodule update --init --recursive

# Build the project with tests enabled
RUN mkdir build && \
    cd build && \
    cmake .. -G "Ninja" \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_TESTING=ON && \
    ninja

# Build tests
RUN cd build && ninja test

# Copy the test runner script
COPY run_tests.sh /chrono/

# Make it executable
RUN chmod +x /chrono/run_tests.sh

# Default command to run tests
CMD ["/chrono/run_tests.sh"]