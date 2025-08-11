#!/bin/bash

# CPR Development Environment Script

# Build the project
build() {
    echo "Building CPR..."
    cd /app/build
    cmake .. -DCPR_BUILD_TESTS=ON -DCPR_BUILD_TESTS_SSL=ON -DCPR_FORCE_OPENSSL_BACKEND=ON -DCPR_USE_SYSTEM_CURL=ON
    cmake --build . --parallel
    echo "Build completed!"
}

# Run all tests
test_all() {
    echo "Running all tests..."
    cd /app/build
    ctest -VV
}

# Run specific test
test_single() {
    if [ -z "$1" ]; then
        echo "Please provide a test name. Available tests:"
        cd /app/build
        ctest -N
        return 1
    fi
    
    echo "Running test: $1"
    cd /app/build
    ctest -R "^$1$" -VV
}

# Clean build
clean() {
    echo "Cleaning build directory..."
    rm -rf /app/build/*
    echo "Clean completed!"
}

# Show help
show_help() {
    echo "CPR Development Environment Script"
    echo "Usage: ./dev.sh [command]"
    echo ""
    echo "Commands:"
    echo "  build          Build the project"
    echo "  test           Run all tests"
    echo "  test <name>    Run specific test"
    echo "  clean          Clean build directory"
    echo "  help           Show this help message"
}

# Main script logic
case "$1" in
    build)
        build
        ;;
    test)
        if [ -z "$2" ]; then
            test_all
        else
            test_single "$2"
        fi
        ;;
    clean)
        clean
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