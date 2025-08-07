FROM ubuntu:18.04

# Install dependencies required for building and testing
RUN apt-get update && apt-get install -y \
    g++ \
    python \
    cmake \
    make \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Default command runs all tests
# To run specific tests, override this with: 
# docker run --rm clipp-dev bash -c "cd test && python run_tests.py -c gcc <specific_test>"
CMD ["bash", "-c", "cd test && python run_tests.py -c gcc"]