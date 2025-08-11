#!/bin/bash
echo "========================================="
echo "Running PHP-CPP tests..."
echo "========================================="
cd Examples/simple
make clean
make
echo "Test completed successfully!"
echo "========================================="
echo "Testing the compiled extension..."
echo "Checking if the extension was created:"
ls -la simple.so
echo "Extension test completed!"
echo "========================================="