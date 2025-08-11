FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libwxgtk3.0-gtk3-dev \
    git \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the source code
COPY . .

# Update submodules
RUN git submodule sync && git submodule update --init

# Create build directory and build the library with CMake
RUN mkdir build && cd build && cmake .. && make && make install

# Set environment variables for the tests
ENV WXCHARTS=/usr/local
ENV CATCH2_ROOT=/app/3rdparty/Catch2

# Modify the GNUmakefile to use the correct include paths and C++ standard
# Also disable the problematic signal stack handling in Catch2 by defining CATCH_CONFIG_NO_POSIX_SIGNALS before including catch.hpp
RUN sed -i 's|WXCHARTS_ROOT|WXCHARTS|g' /app/tests/GNUmakefile && \
    sed -i 's|-I$(WXCHARTS_ROOT)/include|-I$(WXCHARTS)/include/wxcharts|g' /app/tests/GNUmakefile && \
    sed -i 's|-I$(WXCHARTS)/include/wxcharts|-I/usr/local/include/wxcharts|g' /app/tests/GNUmakefile && \
    sed -i 's|`wx-config --cxxflags`|`wx-config --cxxflags` -I/usr/local/include/wxcharts|g' /app/tests/GNUmakefile && \
    sed -i 's|-std=c++11|-std=c++14 -DCATCH_CONFIG_NO_POSIX_SIGNALS|g' /app/tests/GNUmakefile

# Build the tests
WORKDIR /app/tests
RUN make WXCHARTS=/usr/local CATCH2_ROOT=/app/3rdparty/Catch2

# Run the tests in a virtual framebuffer
CMD ["xvfb-run", "-a", "./wxchartstests"]