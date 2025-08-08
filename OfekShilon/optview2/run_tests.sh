#!/bin/bash
# Script to run unit tests for OptView2

set -e

echo "Running OptView2 tests..."

# Run the example project to verify functionality
cd cpp_optimization_example
bash run_optview2.sh

# Check if output files were generated
if [ -d "html_output" ] && [ -f "html_output/index.html" ]; then
    echo "✅ Tests passed! HTML output was generated successfully."
    exit 0
else
    echo "❌ Tests failed! HTML output was not generated."
    exit 1
fi