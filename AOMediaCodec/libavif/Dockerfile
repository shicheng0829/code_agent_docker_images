# Use Ubuntu 22.04 as the base image to get a newer CMake version
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
# Note: Some packages like libdav1d-dev, librav1e-dev, and libyuv-dev are not available in Ubuntu 20.04 repositories.
# We will build them from source or use alternative approaches.
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    meson \
    nasm \
    pkg-config \
    libjpeg-turbo8-dev \
    libpng-dev \
    libaom-dev \
    libxml2-dev \
    imagemagick \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Rust for building rav1e
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Configure the build with all codecs enabled locally
# We'll use LOCAL for codecs that are not available as system packages
RUN cmake -G Ninja -S . -B build \
    -DCMAKE_BUILD_TYPE=Debug \
    -DBUILD_SHARED_LIBS=OFF \
    -DAVIF_CODEC_AOM=SYSTEM \
    -DAVIF_CODEC_DAV1D=LOCAL \
    -DAVIF_CODEC_RAV1E=LOCAL \
    -DAVIF_CODEC_SVT=LOCAL \
    -DAVIF_CODEC_LIBGAV1=LOCAL \
    -DAVIF_LIBSHARPYUV=LOCAL \
    -DAVIF_LIBXML2=SYSTEM \
    -DAVIF_LIBYUV=LOCAL \
    -DAVIF_BUILD_EXAMPLES=ON \
    -DAVIF_BUILD_APPS=ON \
    -DAVIF_BUILD_TESTS=ON \
    -DAVIF_GTEST=LOCAL \
    -DAVIF_ENABLE_EXPERIMENTAL_MINI=ON \
    -DAVIF_ENABLE_EXPERIMENTAL_SAMPLE_TRANSFORM=ON \
    -DAVIF_ENABLE_EXPERIMENTAL_EXTENDED_PIXI=ON \
    -DAVIF_ENABLE_WERROR=ON

# Build the project
RUN cmake --build build --config Debug --parallel 4

# Run tests
CMD ["ctest", "-j", "4", "--output-on-failure", "--test-dir", "build"]