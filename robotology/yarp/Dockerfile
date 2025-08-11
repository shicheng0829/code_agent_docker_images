# SPDX-FileCopyrightText: 2006-2021 Istituto Italiano di Tecnologia (IIT)
# SPDX-FileCopyrightText: 2006-2010 RobotCub Consortium
# SPDX-License-Identifier: BSD-3-Clause

FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for YARP build and tests
RUN apt-get update && apt-get install -y \
    # Basic build tools
    build-essential \
    cmake \
    ninja-build \
    ccache \
    git \
    wget \
    curl \
    # YARP core dependencies
    libace-dev \
    # Database and XML libraries
    libsqlite3-dev \
    libtinyxml-dev \
    libtinyxml2-dev \
    libedit-dev \
    # GUI dependencies
    qtbase5-dev \
    qtdeclarative5-dev \
    qtmultimedia5-dev \
    libqt5opengl5-dev \
    libqcustomplot-dev \
    # Math and visualization libraries
    libopencv-dev \
    libeigen3-dev \
    libgraphviz-dev \
    libpng-dev \
    libv4l-dev \
    # Audio/video libraries
    libavcodec-dev \
    libavdevice-dev \
    libavformat-dev \
    libavutil-dev \
    portaudio19-dev \
    libsdl1.2-dev \
    # Hardware interface libraries
    libopenni2-dev \
    libftdi-dev \
    libi2c-dev \
    libjpeg-dev \
    # Point cloud library
    libpcl-dev \
    # GStreamer support
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    # Bindings dependencies
    mono-mcs \
    liblua5.3-dev \
    lua5.3 \
    tcl-dev \
    tk-dev \
    python3-dev \
    octave-dev \
    ruby-dev \
    ruby \
    perl \
    openjdk-17-jdk \
    openjdk-17-jre \
    # Testing dependencies
    librobottestingframework-dev \
    valgrind \
    # SWIG for bindings
    # We install SWIG 4.3.0 manually to avoid a known bug
    && apt-get purge -y swig \
    && wget -nv https://github.com/robotology/robotology-vcpkg-ports/releases/download/storage/swig_4_3_0_ubuntu_24_04.zip \
    && apt-get install -y unzip \
    && unzip -q swig_4_3_0_ubuntu_24_04.zip \
    && mv swig_4_3_0_ubuntu_24_04_install/bin/* /usr/bin \
    && mv swig_4_3_0_ubuntu_24_04_install/share/swig /usr/share \
    # Install YCM (YARP CMake Modules)
    && wget -nv https://github.com/robotology/ycm/releases/download/v0.15.3/ycm-cmake-modules-0.15.3-all.deb \
    && dpkg -i ycm-cmake-modules-0.15.3-all.deb \
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* ycm-cmake-modules-0.15.3-all.deb swig_4_3_0_ubuntu_24_04.zip swig_4_3_0_ubuntu_24_04_install

# Install clang-17 (as used in CI)
RUN apt-get update \
    && apt-get install -y lsb-release wget software-properties-common gnupg \
    && wget -nv https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 17 all \
    && rm llvm.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up environment variables
ENV CC=/usr/bin/clang-17
ENV CXX=/usr/bin/clang++-17
ENV CFLAGS=-fcolor-diagnostics
ENV CXXFLAGS=-fcolor-diagnostics
ENV YARP_PORT_RANGE=20000
ENV CTEST_OUTPUT_ON_FAILURE=1

# Set working directory
WORKDIR /yarp

# Copy YARP source code
COPY . .

# Create build directory and configure
RUN mkdir build && cd build \
    && cmake .. \
       -DCMAKE_BUILD_TYPE=Release \
       -DYARP_COMPILE_TESTS=ON \
       -DYARP_COMPILE_EXAMPLES=ON \
       -DYARP_COMPILE_BINDINGS=ON \
       -DYARP_ENABLE_EXAMPLES_AS_TESTS=ON \
       -DCREATE_PYTHON=ON \
       -DCREATE_LUA=ON \
       -DCREATE_RUBY=ON \
       -DCREATE_TCL=ON \
       -DCREATE_JAVA=ON \
       -DCREATE_CSHARP=ON \
       -DCREATE_PERL=ON \
       -DCREATE_OCTAVE=OFF

# Build YARP
RUN cd build && make -j$(nproc)

# Default command runs tests
CMD ["ctest", "--test-dir", "/yarp/build", "--output-on-failure"]