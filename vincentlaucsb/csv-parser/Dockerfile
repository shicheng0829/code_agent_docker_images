# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    cmake \
    make \
    python3 \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/csv-parser

# Copy source code
COPY . .

# Build the project
RUN cmake -DCMAKE_BUILD_TYPE=Debug -DCSV_CXX_STANDARD=17 . && \
    make csv_test

# Document how to run tests (requires test data)
# To run tests, you need to mount the test data directory:
# docker run -v $(pwd)/tests:/usr/src/csv-parser/tests csv-parser-dev ./tests/csv_test

# Default command - just keep the container running
CMD ["bash"]