#!/bin/bash
# Run unit tests in the chrono Docker container

# Build the project if not already built
if [ ! -d "build" ]; then
    mkdir build
    cd build
    cmake .. -G "Ninja" -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=ON
    ninja
    cd ..
fi

# Run tests
cd build
ctest --output-on-failure