#!/bin/bash

# Test script for ImGui development

echo "=== ImGui Development Environment Test ==="

# Test 1: Compile null example
echo "Test 1: Compiling null example..."
make -C examples/example_null clean
make -C examples/example_null WITH_EXTRA_WARNINGS=1
if [ $? -eq 0 ]; then
    echo "✓ Null example compiled successfully"
else
    echo "✗ Failed to compile null example"
    exit 1
fi

# Test 2: Run null example
echo "Test 2: Running null example..."
./examples/example_null/example_null
if [ $? -eq 0 ]; then
    echo "✓ Null example ran successfully"
else
    echo "✗ Failed to run null example"
    exit 1
fi

# Test 3: Compile with different flags
echo "Test 3: Compiling with IMGUI_DISABLE_OBSOLETE_FUNCTIONS..."
cat > example_single_file.cpp <<'EOF'

#define IMGUI_DISABLE_OBSOLETE_FUNCTIONS
#define IMGUI_IMPLEMENTATION
#include "misc/single_file/imgui_single_file.h"
#include "examples/example_null/main.cpp"

EOF
g++ -I. -std=c++11 -Wall -Wformat -o example_single_file example_single_file.cpp
if [ $? -eq 0 ]; then
    echo "✓ Compiled with IMGUI_DISABLE_OBSOLETE_FUNCTIONS successfully"
    rm example_single_file example_single_file.cpp
else
    echo "✗ Failed to compile with IMGUI_DISABLE_OBSOLETE_FUNCTIONS"
    exit 1
fi

# Test 4: Compile with freetype
echo "Test 4: Compiling with freetype support..."
make -C examples/example_null clean
make -C examples/example_null WITH_FREETYPE=1
if [ $? -eq 0 ]; then
    echo "✓ Compiled with freetype support successfully"
else
    echo "✗ Failed to compile with freetype support"
    exit 1
fi

echo "=== All tests passed! ==="