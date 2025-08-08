#!/bin/bash

# Test script for DebugView++ development environment

echo "Testing DebugView++ development environment..."
echo "=============================================="

# Check if required tools are available
echo "Checking for required tools:"
echo "---------------------------"

# Check CMake
if command -v cmake &> /dev/null; then
    echo "✓ CMake: $(cmake --version | head -n 1)"
else
    echo "✗ CMake not found"
fi

# Check GCC
if command -v gcc &> /dev/null; then
    echo "✓ GCC: $(gcc --version | head -n 1)"
else
    echo "✗ GCC not found"
fi

# Check G++
if command -v g++ &> /dev/null; then
    echo "✓ G++: $(g++ --version | head -n 1)"
else
    echo "✗ G++ not found"
fi

# Check Clang tools
if command -v clang &> /dev/null; then
    echo "✓ Clang: $(clang --version | head -n 1)"
else
    echo "✗ Clang not found"
fi

if command -v clang-tidy &> /dev/null; then
    echo "✓ Clang-tidy: $(clang-tidy --version | head -n 1)"
else
    echo "✗ Clang-tidy not found"
fi

if command -v cppcheck &> /dev/null; then
    echo "✓ Cppcheck: $(cppcheck --version)"
else
    echo "✗ Cppcheck not found"
fi

# Check Python
if command -v python3 &> /dev/null; then
    echo "✓ Python3: $(python3 --version)"
else
    echo "✗ Python3 not found"
fi

# Check Ninja
if command -v ninja &> /dev/null; then
    echo "✓ Ninja: $(ninja --version)"
else
    echo "✗ Ninja not found"
fi

echo ""
echo "Source code structure:"
echo "----------------------"
ls -la

echo ""
echo "Running basic code analysis with cppcheck:"
echo "------------------------------------------"
cppcheck --enable=warning,style --error-exitcode=1 --quiet . 2>/dev/null || echo "Cppcheck completed (warnings may be shown above)"

echo ""
echo "Development environment test completed."