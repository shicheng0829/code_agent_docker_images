#!/bin/bash

# Script to build and run cpp-TimSort development Docker container

# Build the Docker image
echo "Building Docker image..."
docker build -t cpp-timsort-dev .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Docker image built successfully!"
    
    # Run tests in the container
    echo "Running tests..."
    docker run --rm cpp-timsort-dev ctest -C Release --test-dir build
    
    # Check if tests passed
    if [ $? -eq 0 ]; then
        echo "All tests passed!"
        echo "You can now run the container with:"
        echo "  docker run -it cpp-timsort-dev"
    else
        echo "Some tests failed!"
        exit 1
    fi
else
    echo "Docker build failed!"
    exit 1
fi