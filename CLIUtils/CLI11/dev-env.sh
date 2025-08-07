#!/bin/bash

# CLI11 Development Environment Script

# Build the Docker image
build_image() {
    echo "Building CLI11 development Docker image..."
    docker build -t cli11-dev .
}

# Run tests in the Docker container
run_tests() {
    echo "Running tests in Docker container..."
    docker run --rm cli11-dev ctest --output-on-failure -C Debug
}

# Run an interactive shell in the Docker container
run_shell() {
    echo "Starting interactive shell in Docker container..."
    docker run -it --rm -v $(pwd):/app cli11-dev /bin/bash
}

# Clean up Docker resources
cleanup() {
    echo "Cleaning up Docker resources..."
    docker rmi cli11-dev 2>/dev/null || true
}

# Show help
show_help() {
    echo "CLI11 Development Environment Script"
    echo "Usage: ./dev-env.sh [command]"
    echo ""
    echo "Commands:"
    echo "  build     Build the Docker image"
    echo "  test      Run tests in the Docker container"
    echo "  shell     Run an interactive shell in the Docker container"
    echo "  clean     Clean up Docker resources"
    echo "  help      Show this help message"
}

# Main script logic
case "$1" in
    build)
        build_image
        ;;
    test)
        run_tests
        ;;
    shell)
        run_shell
        ;;
    clean)
        cleanup
        ;;
    help|"")
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        show_help
        exit 1
        ;;
esac