#!/bin/bash

# 构建项目
echo "Building the serial project..."
source /opt/ros/noetic/setup.bash
mkdir -p build
cd build
cmake ..
make

echo "Build completed successfully!"

# 提供运行测试的说明
echo ""
echo "To run tests (requires serial device):"
echo "  make test"
echo ""
echo "For running tests with a real serial device, you would need to:"
echo "  1. Connect a serial device or create a virtual one (e.g., using socat)"
echo "  2. Modify the test files to use the correct device path"
echo "  3. Run the tests with appropriate permissions"
echo ""
echo "Example of creating virtual serial ports for testing:"
echo "  socat -d -d pty,raw,echo=0 pty,raw,echo=0"
echo ""
echo "Then modify the test files to use the generated device paths."