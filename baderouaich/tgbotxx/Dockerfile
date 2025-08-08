FROM ubuntu:latest

# Install dependencies including git
RUN apt-get update && \
    apt-get install -y cmake g++ make ninja-build libssl-dev git && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/tgbotxx

# Copy source code
COPY . .

# Create build directory and build the project without tests to avoid token requirement
RUN mkdir cmake-build-debug && \
    cd cmake-build-debug && \
    cmake .. -GNinja -DCMAKE_BUILD_TYPE=Debug && \
    ninja

# Command to run tests (requires TESTS_BOT_TOKEN environment variable)
# To run tests, you would need to provide the token when running the container:
# docker run -e TESTS_BOT_TOKEN=your_token_here tgbotxx-test