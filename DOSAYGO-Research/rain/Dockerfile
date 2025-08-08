# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    llvm \
    libomp-dev \
    zlib1g-dev \
    nodejs \
    npm \
    curl \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install Emscripten
RUN git clone https://github.com/emscripten-core/emsdk.git /emsdk && \
    cd /emsdk && \
    ./emsdk install latest && \
    ./emsdk activate latest

# Set up Emscripten environment
ENV PATH="/emsdk:/emsdk/upstream/emscripten:${PATH}"
ENV EMSDK="/emsdk"
ENV EM_CONFIG="/emsdk/.emscripten"
ENV EM_CACHE="/emsdk/upstream/emscripten/cache"

# Create working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Node.js dependencies
RUN cd js && npm install && cd .. && \
    cd scripts && npm install && cd ..

# Modify Makefile to use system clang++ instead of hardcoded path
RUN sed -i 's|/opt/homebrew/opt/llvm/bin/clang++|clang++|g' Makefile && \
    sed -i 's|-isysroot $$(shell xcrun --show-sdk-path)||g' Makefile && \
    sed -i 's|-I/opt/homebrew/opt/llvm/include||g' Makefile && \
    sed -i 's|-L/opt/homebrew/opt/llvm/lib||g' Makefile

# Build the project
RUN make clean && make

# Default command to run tests
CMD ["./scripts/verify.sh"]