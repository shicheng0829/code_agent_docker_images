# Use Ubuntu 24.04 as the base image, matching the CI environment
FROM ubuntu:24.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for building and testing LLGL
# Excluding Vulkan SDK for now to see if we can build without it
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        libx11-dev \
        libxrandr-dev \
        libglu1-mesa-dev \
        freeglut3-dev \
        mesa-common-dev \
        xvfb \
        git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /usr/src/LLGL

# Copy the entire project into the container
COPY . .

# Initialize and update submodules to ensure external dependencies are available
RUN git submodule update --init --recursive

# Configure CMake for a minimal build that includes tests
# Disabling Vulkan renderer since we're not installing the SDK
# Setting GaussLib_INCLUDE_DIR to the external submodule path
RUN cmake -S . -B ./build \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLGL_BUILD_STATIC_LIB=OFF \
    -DLLGL_BUILD_RENDERER_NULL=ON \
    -DLLGL_BUILD_RENDERER_OPENGL=ON \
    -DLLGL_BUILD_RENDERER_VULKAN=OFF \
    -DLLGL_BUILD_EXAMPLES=OFF \
    -DLLGL_BUILD_TESTS=ON \
    -DLLGL_BUILD_WRAPPER_C99=OFF \
    -DLLGL_VK_ENABLE_SPIRV_REFLECT=OFF \
    -DLLGL_GL_ENABLE_DSA_EXT=OFF \
    -DLLGL_GL_ENABLE_VENDOR_EXT=OFF \
    -DGaussLib_INCLUDE_DIR=/usr/src/LLGL/external/GaussianLib/include

# Build the project
RUN cmake --build ./build --config Release

# Define the command to run tests using xvfb for headless execution
CMD ["xvfb-run", "./build/tests/Testbed/Testbed", "gl", "-v", "-f", "-t"]