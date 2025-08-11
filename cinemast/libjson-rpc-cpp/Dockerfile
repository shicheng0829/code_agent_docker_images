FROM debian:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    cmake \
    libjsoncpp-dev \
    libargtable2-dev \
    libcurl4-openssl-dev \
    libmicrohttpd-dev \
    git \
    libhiredis-dev \
    redis-server \
    lcov \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the project
RUN mkdir -p build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX="/usr/local" \
          -DWITH_COVERAGE=YES \
          -DCMAKE_BUILD_TYPE=Release \
          -DBUILD_STATIC_LIBS=ON \
          -DTCP_SOCKET_SERVER=YES \
          -DTCP_SOCKET_CLIENT=YES \
          -DBUILD_SHARED_LIBS=ON \
          -DUNIX_DOMAIN_SOCKET_SERVER=NO \
          -DUNIX_DOMAIN_SOCKET_CLIENT=NO \
          .. && \
    make

# Default command to run tests
CMD ["bash", "-c", "cd build && ./bin/unit_testsuite --durations yes"]