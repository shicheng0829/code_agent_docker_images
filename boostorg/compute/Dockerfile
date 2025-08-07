FROM ubuntu:xenial

# Install dependencies
RUN apt-get update && apt-get install -y \
    g++-5 \
    libltdl-dev \
    libhwloc-dev \
    pkg-config \
    libedit-dev \
    libboost-chrono1.58-dev \
    libboost-date-time1.58-dev \
    libboost-test1.58-dev \
    libboost-system1.58-dev \
    libboost-filesystem1.58-dev \
    libboost-timer1.58-dev \
    libboost-program-options1.58-dev \
    libboost-thread1.58-dev \
    python-yaml \
    libopencv-dev \
    cmake \
    wget \
    git \
    opencl-headers \
    ocl-icd-opencl-dev \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV CMAKE_OPTIONS="-DBOOST_COMPUTE_BUILD_EXAMPLES=ON -DBOOST_COMPUTE_HAVE_OPENCV=ON"
ENV CXX_FLAGS="-Wall -pedantic -Wno-variadic-macros -Wno-long-long -Wno-shadow"

# Set working directory
WORKDIR /compute

# Copy the source code
COPY . /compute

# Build the project
RUN mkdir -p build && \
    cd build && \
    cmake ${CMAKE_OPTIONS} -DCMAKE_CXX_FLAGS="${CXX_FLAGS}" .. && \
    make -j4

# Set the working directory to the build directory
WORKDIR /compute/build

# Set the default command to run the list_devices example
CMD ["./example/list_devices"]