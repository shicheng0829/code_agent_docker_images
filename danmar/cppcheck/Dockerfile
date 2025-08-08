FROM ubuntu:24.04

WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    g++ \
    make \
    libxml2-utils \
    libpcre3-dev \
    python3 \
    ccache \
    && rm -rf /var/lib/apt/lists/*

# Copy the source code
COPY . .

# Create build directory
RUN mkdir cmake.output

# Build the project
RUN cd cmake.output && \
    cmake -G "Unix Makefiles" -DHAVE_RULES=On -DBUILD_TESTS=On -DCMAKE_DISABLE_PRECOMPILE_HEADERS=On -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache .. && \
    cmake --build . -- -j$(nproc)

# Run tests
CMD ["cmake", "--build", "cmake.output", "--target", "check", "--", "-j4"]