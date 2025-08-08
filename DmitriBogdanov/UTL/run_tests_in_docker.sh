#!/bin/bash

# Script to build and run the UTL development Docker container

# Build the Docker image
echo "Building Docker image..."
docker build -t utl-dev .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Docker image built successfully!"
    
    # Run the tests in the container
    echo "Running tests in Docker container..."
    docker run --rm utl-dev
else
    echo "Docker build failed!"
    exit 1
fi