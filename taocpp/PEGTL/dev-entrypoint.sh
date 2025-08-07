#!/bin/bash
if [ "$#" -eq 0 ]; then
  echo "Available commands:"
  echo "  build        - Build the project"
  echo "  test         - Run all tests"
  echo "  test-single  - Run a single test (provide test name)"
  echo "  clean        - Clean build directory"
  echo "  bash         - Start interactive shell"
  echo ""
  echo "Usage: docker run -it pegtl-dev:<command>"
else
  case "$1" in
    build)
      mkdir -p build && cd build && cmake .. -GNinja && cmake --build .
      ;;
    test)
      mkdir -p build && cd build && cmake .. -GNinja && cmake --build . && ctest --output-on-failure
      ;;
    test-single)
      if [ -z "$2" ]; then
        echo "Please provide a test name"
        exit 1
      fi
      mkdir -p build && cd build && cmake .. -GNinja && cmake --build . && ctest -R "$2" --output-on-failure
      ;;
    clean)
      rm -rf build/*
      ;;
    bash)
      exec /bin/bash
      ;;
    *)
      echo "Unknown command: $1"
      exit 1
      ;;
  esac
fi