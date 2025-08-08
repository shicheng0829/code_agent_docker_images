# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including Vulkan from Ubuntu repositories
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    python3 \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev \
    libxext-dev \
    libwayland-dev \
    libxkbcommon-dev \
    libegl1-mesa-dev \
    curl \
    libvulkan-dev \
    vulkan-tools \
    spirv-tools \
    glslang-dev \
    glslang-tools \
    && rm -rf /var/lib/apt/lists/*

# Configure git to use HTTPS instead of SSH to avoid SSH key issues
RUN git config --global url."https://github.com/".insteadOf git@github.com:

# Install Premake5 by compiling from source
WORKDIR /tmp
RUN git clone https://github.com/premake/premake-core.git \
    && cd premake-core \
    && git checkout v5.0.0-beta1 \
    && make -f Bootstrap.mak linux \
    && cp bin/release/premake5 /usr/local/bin/

# Set up the project
WORKDIR /app
COPY . .

# Update submodules
RUN git submodule update --init --recursive

# Generate project files with Premake
RUN premake5 gmake2

# Build the project
RUN make -j$(nproc)

# Default command
CMD ["/bin/bash"]