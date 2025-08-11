#!/bin/bash

# Onion Development Helper Script

case "$1" in
    build)
        echo "Building Docker image..."
        docker build -t onion-dev .
        ;;
    test)
        echo "Running all tests..."
        docker run --rm onion-dev sh -c "cd build && ctest --output-on-failure"
        ;;
    test-one)
        if [ -z "$2" ]; then
            echo "Usage: $0 test-one <test-name>"
            exit 1
        fi
        echo "Running test: $2"
        docker run --rm onion-dev sh -c "cd build && ctest --output-on-failure -R $2"
        ;;
    shell)
        echo "Starting interactive shell..."
        docker run -it -v $(pwd):/app onion-dev bash
        ;;
    clean)
        echo "Cleaning build directory..."
        docker run -it -v $(pwd):/app onion-dev bash -c "rm -rf build/*"
        ;;
    rebuild)
        echo "Rebuilding project..."
        docker run -it -v $(pwd):/app onion-dev bash -c "cd build && make"
        ;;
    *)
        echo "Onion Development Helper Script"
        echo "Usage: $0 {build|test|test-one <name>|shell|clean|rebuild}"
        echo ""
        echo "Commands:"
        echo "  build      - Build the Docker image"
        echo "  test       - Run all tests"
        echo "  test-one   - Run a specific test by name"
        echo "  shell      - Start an interactive shell"
        echo "  clean      - Clean the build directory"
        echo "  rebuild    - Rebuild the project"
        ;;
esac