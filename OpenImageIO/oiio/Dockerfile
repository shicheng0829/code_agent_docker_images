# Use Ubuntu 22.04 as the base image (similar to what's used in CI)
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies needed for building OpenImageIO
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    ninja-build \
    ccache \
    g++ \
    libtiff-dev \
    libgif-dev \
    libpng-dev \
    libraw-dev \
    libwebp-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libavutil-dev \
    dcmtk \
    libfreetype6-dev \
    libopencolorio-dev \
    libtbb-dev \
    python3 \
    python3-dev \
    python3-pip \
    python3-numpy \
    qtbase5-dev \
    libqt5opengl5-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libopenexr-dev \
    libopenjp2-7-dev \
    libheif-dev \
    && rm -rf /var/lib/apt/lists/*

# Install additional Python packages
RUN pip3 install pybind11

# Set working directory
WORKDIR /opt

# Clone and build Imath (required dependency)
RUN git clone https://github.com/AcademySoftwareFoundation/Imath.git
WORKDIR /opt/Imath
RUN mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local && cmake --build . --target install

# Clone and build OpenEXR (required dependency)
WORKDIR /opt
RUN git clone https://github.com/AcademySoftwareFoundation/openexr.git
WORKDIR /opt/openexr
RUN mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local && cmake --build . --target install

# Set working directory for OIIO
WORKDIR /opt

# Clone OpenImageIO
RUN git clone https://github.com/AcademySoftwareFoundation/OpenImageIO.git
WORKDIR /opt/OpenImageIO

# Create build directory
RUN mkdir build

# Build OpenImageIO with tests enabled
WORKDIR /opt/OpenImageIO/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/opt/OpenImageIO/dist \
    -DOIIO_BUILD_TESTS=ON \
    -DOIIO_BUILD_TOOLS=ON \
    -DUSE_PYTHON=ON \
    -DPYTHON_VERSION=3

RUN cmake --build . --target install --parallel $(nproc)

# Set environment variables for running tests
ENV OpenImageIO_ROOT=/opt/OpenImageIO/dist
ENV LD_LIBRARY_PATH=/opt/OpenImageIO/dist/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH=/opt/OpenImageIO/dist/lib/python3/site-packages:$PYTHONPATH
ENV PATH=/opt/OpenImageIO/dist/bin:$PATH

# Download test data
RUN cmake --build . --target download-test-data

# Set the default command to run tests
CMD ["ctest", "-V"]