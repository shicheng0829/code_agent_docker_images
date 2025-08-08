#!/bin/bash

echo "Testing PocketFFT implementation..."

# Compile the demo program
echo "Compiling demo program..."
g++ -std=c++11 -O3 -ffast-math -pthread -o pocketfft_demo pocketfft_demo.cc

if [ $? -ne 0 ]; then
    echo "Demo compilation failed"
    exit 1
fi

echo "Demo compilation successful"

# Compile the test program
echo "Compiling test program..."
g++ -std=c++11 -O3 -ffast-math -pthread -o test_pocketfft test_pocketfft.cc

if [ $? -ne 0 ]; then
    echo "Test compilation failed"
    exit 1
fi

echo "Test compilation successful"

# Run a quick test of the demo
echo "Running quick demo test..."
timeout 5s ./pocketfft_demo | head -10

if [ $? -eq 0 ]; then
    echo "Quick demo test completed successfully"
else
    echo "Quick demo test failed"
    exit 1
fi

# Run the comprehensive test
echo "Running comprehensive tests..."
timeout 30s ./test_pocketfft

if [ $? -eq 0 ]; then
    echo "Comprehensive tests completed successfully"
else
    echo "Comprehensive tests failed"
    exit 1
fi

echo "All tests passed!"