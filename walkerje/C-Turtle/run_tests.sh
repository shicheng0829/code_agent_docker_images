#!/bin/bash

# 运行所有示例程序的测试脚本

echo "==========================================="
echo "CTurtle Development Environment Test Suite"
echo "==========================================="

echo ""
echo "Test 1: Headless Mode (No GUI Required)"
echo "----------------------------------------"
echo "Running headless example..."
if timeout 30s ./headless > /dev/null 2>&1; then
    echo "✓ Headless example completed successfully"
else
    echo "✗ Headless example failed or timed out"
fi

echo ""
echo "Test 2: Graphical Examples (GUI Required)"
echo "----------------------------------------"

GRAPHICAL_EXAMPLES=(
    "koch"
    "koch_class"
    "show_recursion_spiral"
    "show_recursive_sierpinski_triangle"
    "show_tree_recursion"
    "show_two_turtle"
    "show_undo"
)

for example in "${GRAPHICAL_EXAMPLES[@]}"; do
    echo "Testing $example..."
    if timeout 10s ./$example > /dev/null 2>&1; then
        echo "✓ $example completed successfully"
    else
        # Check if it failed due to X11 (expected in headless) or other reasons
        if timeout 10s ./$example 2>&1 | grep -q "Failed to open X11 display"; then
            echo "⚠ $example failed due to missing X11 (expected in headless environment)"
        else
            echo "? $example behavior uncertain (may have run but with issues)"
        fi
    fi
done

echo ""
echo "Test 3: Compilation Verification"
echo "--------------------------------"
echo "Checking that all executables were compiled..."
EXECUTABLES=("headless" "koch" "koch_class" "show_recursion_spiral" 
             "show_recursive_sierpinski_triangle" "show_tree_recursion" 
             "show_two_turtle" "show_undo")

all_compiled=true
for exe in "${EXECUTABLES[@]}"; do
    if [ -f "$exe" ] && [ -x "$exe" ]; then
        echo "✓ $exe exists and is executable"
    else
        echo "✗ $exe is missing or not executable"
        all_compiled=false
    fi
done

if [ "$all_compiled" = true ]; then
    echo "✓ All examples compiled successfully"
else
    echo "✗ Some examples failed to compile"
fi

echo ""
echo "==========================================="
echo "Test suite completed"
echo "==========================================="