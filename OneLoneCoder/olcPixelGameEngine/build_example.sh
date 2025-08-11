#!/bin/bash

# Compile the test program
echo "Compiling test program..."
g++ -I. -o test_example olcExampleProgram.cpp -lX11 -lGL -lpthread -lpng -lstdc++fs -std=c++17

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful!"
    echo "To run the test program, use: ./test_example"
else
    echo "Compilation failed!"
    exit 1
fi