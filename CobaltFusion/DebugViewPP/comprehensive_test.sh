#!/bin/bash

# Comprehensive test script for DebugView++ development environment

echo "Comprehensive DebugView++ Development Environment Test"
echo "======================================================"

# Check if required tools are available
echo "1. Checking for required tools:"
echo "-------------------------------"

TOOLS=("cmake" "gcc" "g++" "clang-tidy" "cppcheck" "python3" "ninja" "git")
MISSING_TOOLS=()

for tool in "${TOOLS[@]}"; do
    if command -v "$tool" &> /dev/null; then
        version=$($tool --version 2>/dev/null | head -n 1)
        echo "✓ $tool: $version"
    else
        echo "✗ $tool: NOT FOUND"
        MISSING_TOOLS+=("$tool")
    fi
done

if [ ${#MISSING_TOOLS[@]} -ne 0 ]; then
    echo "Warning: Missing tools: ${MISSING_TOOLS[*]}"
fi

echo ""
echo "2. Source code structure:"
echo "-------------------------"
find . -name "*.h" -o -name "*.cpp" -o -name "*.hpp" | head -10
echo "... (showing first 10 source files)"

echo ""
echo "3. Running Cppcheck analysis:"
echo "-----------------------------"
cppcheck --enable=warning,style --inconclusive --quiet --force . 2>&1 | head -20
echo "... (showing first 20 warnings)"

echo ""
echo "4. Checking CMake configuration:"
echo "--------------------------------"
if [ -f "CMakeLists.txt" ]; then
    echo "Found main CMakeLists.txt:"
    grep -E "^(project|cmake_minimum_required|set)" CMakeLists.txt | head -5
else
    echo "Main CMakeLists.txt not found!"
fi

echo ""
echo "5. Checking for test files:"
echo "---------------------------"
find . -name "*test*" -type f | head -10
echo "... (showing first 10 test-related files)"

echo ""
echo "Comprehensive test completed."