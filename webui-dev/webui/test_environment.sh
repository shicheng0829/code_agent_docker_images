#!/bin/bash

# Test script for WebUI development environment

echo "=== WebUI Development Environment Test ==="

# Check if required tools are available
echo "Checking for required tools..."
which gcc >/dev/null && echo "✓ GCC found" || echo "✗ GCC not found"
which make >/dev/null && echo "✓ Make found" || echo "✗ Make not found"
which npm >/dev/null && echo "✓ NPM found" || echo "✗ NPM not found"
which node >/dev/null && echo "✓ Node.js found" || echo "✗ Node.js not found"
which clang >/dev/null && echo "✓ Clang found" || echo "✗ Clang not found"

# Check WebUI library
echo ""
echo "Checking WebUI library..."
if [ -f "dist/libwebui-2-static.a" ] && [ -f "dist/libwebui-2.so" ]; then
    echo "✓ WebUI library built successfully"
else
    echo "✗ WebUI library not found"
    exit 1
fi

# Test building examples
echo ""
echo "Testing example builds..."

EXAMPLES=("minimal" "call_js_from_c" "serve_a_folder")

for example in "${EXAMPLES[@]}"; do
    if [ -d "examples/C/$example" ]; then
        echo "Building $example example..."
        cd "examples/C/$example"
        make clean >/dev/null 2>&1
        if make >/dev/null 2>&1; then
            echo "✓ $example built successfully"
        else
            echo "✗ Failed to build $example"
        fi
        cd -
    else
        echo "⚠ Example $example not found"
    fi
done

echo ""
echo "=== Test Complete ==="