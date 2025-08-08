FROM ubuntu:20.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    libsqlcipher-dev \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use
ENV DEBIAN_FRONTEND=dialog

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the project
RUN mkdir build && cd build && cmake .. && make

# Run tests
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]