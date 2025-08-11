# Dockerfile for ImGui development and testing
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libglfw3-dev \
    libsdl2-dev \
    libfreetype6-dev \
    libvulkan-dev \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the entire project
COPY . .

# Make test script executable
RUN chmod +x ./run_tests.sh

# Build the null example (headless test)
RUN make -C examples/example_null clean && \
    make -C examples/example_null WITH_EXTRA_WARNINGS=1

# Run basic tests during build
RUN ./run_tests.sh

# Default command to run the null example
CMD ["./examples/example_null/example_null"]