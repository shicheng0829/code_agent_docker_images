#!/bin/bash
# run_tests.sh: Script to run tests in the Docker container

echo "Running tuibox tests..."
echo "======================"

# Run the test program
./demos/test_tuibox

# Check the exit code
if [ $? -eq 0 ]; then
    echo "Tests passed successfully!"
else
    echo "Tests failed or encountered an issue."
fi

echo ""
echo "Available demos:"
ls -la demos/demo_*