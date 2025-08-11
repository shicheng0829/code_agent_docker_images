# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
    build-essential \
    cmake \
    ninja-build \
    doxygen \
    graphviz \
    libcurl4-openssl-dev \
    libprotobuf-dev \
    libprotoc-dev \
    protobuf-compiler \
    libhdf5-dev \
    qtbase5-dev \
    libqwt-qt5-dev \
    curl \
    sudo \
    python3-dev \
    python3-venv \
    gcc-11 \
    g++-11 \
    libasio-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Cap'n Proto
WORKDIR /tmp/capnp
RUN curl -O https://capnproto.org/capnproto-c++-0.9.0.tar.gz && \
    tar zxf capnproto-c++-0.9.0.tar.gz && \
    cd capnproto-c++-0.9.0 && \
    ./configure && \
    make -j$(nproc) && \
    sudo make install && \
    cd ../.. && \
    rm -rf /tmp/capnp

# Create a non-root user
RUN useradd -m -s /bin/bash developer
USER developer
WORKDIR /home/developer

# Copy the project files
COPY --chown=developer:developer . /home/developer/ecal

# Set up Python virtual environment and install requirements
RUN python3 -m venv .venv && \
    . .venv/bin/activate && \
    pip install -r ecal/requirements.txt

# Build the project
RUN . .venv/bin/activate && \
    mkdir build && \
    cd build && \
    export CC=/usr/bin/gcc-11 && \
    export CXX=/usr/bin/g++-11 && \
    cmake ../ecal -G "Ninja" \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
        -DHAS_HDF5=ON \
        -DHAS_QT5=ON \
        -DHAS_CURL=ON \
        -DHAS_CAPNPROTO=ON \
        -DBUILD_DOCS=ON \
        -DBUILD_APPS=ON \
        -DBUILD_SAMPLES=ON \
        -DBUILD_TIME=ON \
        -DBUILD_PY_BINDING=ON \
        -DBUILD_STANDALONE_PY_WHEEL=ON \
        -DBUILD_CSHARP_BINDING=OFF \
        -DBUILD_ECAL_TESTS=ON \
        -DECAL_LAYER_ICEORYX=OFF \
        -DECAL_INCLUDE_PY_SAMPLES=OFF \
        -DECAL_INSTALL_SAMPLE_SOURCES=ON \
        -DECAL_JOIN_MULTICAST_TWICE=OFF \
        -DECAL_NPCAP_SUPPORT=OFF \
        -DECAL_THIRDPARTY_BUILD_CMAKE_FUNCTIONS=ON \
        -DECAL_THIRDPARTY_BUILD_PROTOBUF=OFF \
        -DECAL_THIRDPARTY_BUILD_SPDLOG=ON \
        -DECAL_THIRDPARTY_BUILD_TINYXML2=ON \
        -DECAL_THIRDPARTY_BUILD_FINEFTP=ON \
        -DECAL_THIRDPARTY_BUILD_CURL=OFF \
        -DECAL_THIRDPARTY_BUILD_GTEST=ON \
        -DECAL_THIRDPARTY_BUILD_HDF5=OFF \
        -DECAL_THIRDPARTY_BUILD_RECYCLE=ON \
        -DECAL_THIRDPARTY_BUILD_TCP_PUBSUB=ON \
        -DECAL_THIRDPARTY_BUILD_QWT=OFF \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_SYSCONFDIR=/etc \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_INSTALL_LOCALSTATEDIR=/var \
        -DCMAKE_INSTALL_LIBDIR=lib/x86_64-linux-gnu && \
    sudo mkdir -p /etc/ecal && \
    sudo cp ../ecal/ecal/core/cfg/ecal.ini /etc/ecal && \
    cmake --build . --config Release

# Default command: run tests
CMD ["/bin/bash", "-c", "source .venv/bin/activate && cd build && ctest -V"]