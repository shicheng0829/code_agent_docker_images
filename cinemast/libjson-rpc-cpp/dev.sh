#!/bin/bash

# Script to simplify development with Docker
# Usage: ./dev.sh [command]
# Commands:
#   build     - Build the development Docker image
#   test      - Run unit tests in Docker container
#   shell     - Open a shell in the development Docker container
#   clean     - Remove the development Docker image

case "$1" in
    build)
        echo "Building development Docker image..."
        docker build -f Dockerfile.dev -t libjson-rpc-cpp-dev-env .
        ;;
    test)
        echo "Running unit tests in Docker container..."
        docker run --rm libjson-rpc-cpp-dev-env
        ;;
    shell)
        echo "Opening shell in development Docker container..."
        docker run -it --rm -v $(pwd):/app libjson-rpc-cpp-dev-env /bin/bash
        ;;
    clean)
        echo "Removing development Docker image..."
        docker rmi libjson-rpc-cpp-dev-env
        ;;
    *)
        echo "Usage: $0 [build|test|shell|clean]"
        echo "  build     - Build the development Docker image"
        echo "  test      - Run unit tests in Docker container"
        echo "  shell     - Open a shell in the development Docker container"
        echo "  clean     - Remove the development Docker image"
        exit 1
        ;;
esac