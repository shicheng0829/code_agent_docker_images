# Dockerfile for DebugView++ development (Linux-based for code analysis)
# Note: Full build and testing requires Windows environment

FROM ubuntu:22.04

# Avoid interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install development tools
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    python3 \
    wget \
    unzip \
    clang-tools \
    clang-tidy \
    cppcheck \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Copy source code
COPY . .

# Install any additional dependencies for static analysis
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Make test scripts executable
RUN chmod +x test_env.sh comprehensive_test.sh

# Display project information
RUN echo "=============================================" && \
    echo "DebugView++ Development Environment (Linux)" && \
    echo "=============================================" && \
    echo "Note: This environment is for code analysis only." && \
    echo "Full builds and testing require a Windows environment." && \
    echo "============================================="

# Check source code structure
RUN ls -la

# Default command
CMD ["/bin/bash"]