#!/bin/bash

# Compile the unit tests
echo "Compiling unit tests..."
g++ -o unit_tests unit_tests.cpp olcPixelGameEngine.cpp -lX11 -lGL -lpthread -lpng -lstdc++fs -std=c++17

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful!"
    echo "Running unit tests..."
    ./unit_tests
else
    echo "Compilation failed!"
    exit 1
fi