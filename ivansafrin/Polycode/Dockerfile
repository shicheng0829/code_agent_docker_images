FROM amd64/ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    libsdl1.2-dev \
    python-ply \
    build-essential \
    libgtk2.0-dev \
    libgtkglext1-dev \
    libxmu-dev \
    libxi-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libfreetype6-dev \
    libpng-dev \
    libogg-dev \
    libvorbis-dev \
    libopenal-dev \
    libphysfs-dev \
    libbullet-dev \
    libassimp-dev \
    doxygen \
    wget \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /polycode

# Copy the source code
COPY . .

# Set environment variables to handle cross-compilation issues
ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++

# Build dependencies
RUN mkdir -p Dependencies/Build/Debug Dependencies/Build/Release && \
    cd Dependencies/Build/Debug && \
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug ../.. && \
    make && \
    cd ../Release && \
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ../.. && \
    make

# Build Polycode
RUN mkdir -p Build/Debug Build/Release && \
    cd Build/Debug && \
    cmake -G "Unix Makefiles" -DPOLYCODE_BUILD_BINDINGS=ON -DPOLYCODE_BUILD_PLAYER=ON -DCMAKE_BUILD_TYPE=Debug -DPYTHON_EXECUTABLE=/usr/bin/python2 ../.. && \
    make && \
    make install && \
    cd ../Release && \
    cmake -G "Unix Makefiles" -DPOLYCODE_BUILD_BINDINGS=ON -DPOLYCODE_BUILD_PLAYER=ON -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python2 ../.. && \
    make && \
    make install

# Build Standalone
RUN mkdir -p Standalone/Build && \
    cd Standalone/Build && \
    cmake -G "Unix Makefiles" .. && \
    make install

# Set the default command to run tests/examples
CMD ["/bin/bash"]