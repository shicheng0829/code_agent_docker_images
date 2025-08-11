#!/bin/bash

# Script to run property_tree development environment

# Build the Docker image
echo "Building property_tree development Docker image..."
docker build -t property_tree_dev .

if [ $? -eq 0 ]; then
    echo "Docker image built successfully!"
    echo ""
    echo "Usage:"
    echo "  Run tests:             ./dev.sh test"
    echo "  Interactive shell:     ./dev.sh shell"
    echo "  Run specific command:  ./dev.sh run [command]"
else
    echo "Failed to build Docker image!"
    exit 1
fi

case "$1" in
    test)
        echo "Running tests..."
        docker run --rm property_tree_dev
        ;;
    shell)
        echo "Starting interactive shell..."
        docker run -it --rm -v $(pwd):/app/property_tree property_tree_dev /bin/bash
        ;;
    run)
        shift
        echo "Running command: $@"
        docker run -it --rm -v $(pwd):/app/property_tree property_tree_dev "$@"
        ;;
    *)
        if [ $# -gt 0 ]; then
            echo "Unknown command: $1"
            echo "Available commands: test, shell, run"
        fi
        ;;
esac