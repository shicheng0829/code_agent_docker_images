FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    g++ \
    libboost-all-dev \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /usr/src/jsonv
WORKDIR /usr/src/jsonv

# Build and run tests
CMD ["./config/run-tests"]