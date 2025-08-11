FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    cmake \
    libjpeg8-dev \
    libpng-dev \
    libasound2-dev \
    alsa-utils \
    alsa-oss \
    libx11-dev \
    libxft-dev \
    libxcursor-dev \
    libfreetype6-dev \
    libfontconfig1-dev \
    xvfb \
    x11vnc \
    fluxbox \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . /app

# Create build directory
RUN mkdir build-dev

# Build the project
WORKDIR /app/build-dev
RUN cmake -G"Unix Makefiles" .. -DCMAKE_BUILD_TYPE=Debug -DNANA_CMAKE_ENABLE_JPEG=ON -DNANA_CMAKE_FIND_BOOST_FILESYSTEM=OFF
RUN make -j$(nproc)

# Default command runs tests
CMD ["make", "test"]