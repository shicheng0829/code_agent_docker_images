FROM ubuntu:trusty

# Install dependencies
RUN apt-get -y -qq update && \
    apt-get -y -qq install build-essential cmake libboost-dev libboost-thread-dev libboost-system-dev git

# Copy project files
WORKDIR /app
COPY . .

# Initialize submodules (needed for Google Test)
RUN git submodule update --init --recursive

# Create build directory and compile
RUN mkdir -p build && \
    cd build && \
    cmake -DENABLE_TESTING=ON .. && \
    make

# Default command runs tests
CMD ["sh", "-c", "cd build && ./blackhole-tests"]