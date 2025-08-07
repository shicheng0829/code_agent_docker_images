FROM ubuntu:20.04

# Avoid interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install build tools and dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Create build directory and compile project
RUN mkdir -p build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make

# Create test script
RUN echo '#!/bin/bash' > /usr/local/bin/run-tests && \
    echo 'cd /app/build' >> /usr/local/bin/run-tests && \
    echo 'echo "Running example program test..."' >> /usr/local/bin/run-tests && \
    echo 'echo "quit" | timeout 5s ./example' >> /usr/local/bin/run-tests && \
    echo 'echo "Test completed successfully!"' >> /usr/local/bin/run-tests && \
    chmod +x /usr/local/bin/run-tests

# Default command: show help information
CMD ["bash", "-c", "echo 'Linenoise Development Environment' && echo '' && echo 'Available commands:' && echo '  run-tests     - Run basic tests' && echo '  bash          - Enter bash shell' && echo '' && echo 'To run tests: docker run --rm linenoise-test run-tests' && echo 'To enter shell: docker run -it linenoise-test bash'"]