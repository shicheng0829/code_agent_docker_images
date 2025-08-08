# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install build tools
RUN apt-get update && \
    apt-get install -y build-essential clang && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Build the demo program
RUN clang -g -O2 -Wall -Werror -Wextra -Wno-unused-parameter -Wno-unused-function \
    -o demo DebugHeap.c demo.c

# Create a test script
RUN echo '#!/bin/bash\n\
echo "Running all test cases..."\n\
echo "Test case 0 (setup/teardown):"\n\
./demo 0 && echo "PASS" || echo "FAIL"\n\
echo "\nTest case 1 (array overrun - should crash):"\n\
./demo 1 && echo "FAIL - should have crashed" || echo "PASS - correctly crashed with exit code $?"\n\
echo "\nTest case 2 (double free - should assert):"\n\
./demo 2 2>&1 && echo "FAIL - should have asserted" || echo "PASS - correctly failed with exit code $?"\n\
echo "\nTest case 3 (use after free - should crash):"\n\
./demo 3 && echo "FAIL - should have crashed" || echo "PASS - correctly crashed with exit code $?"\n\
echo "\nAll tests completed."\n'\
> /app/run_tests.sh && chmod +x /app/run_tests.sh

# Default command runs the demo with test case 0 (basic setup/teardown)
CMD ["./demo", "0"]