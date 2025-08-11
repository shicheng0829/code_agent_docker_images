#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print status messages
print_status() {
    echo ">>> $1"
}

# Function to check if a directory exists and is not empty
dir_exists_and_not_empty() {
    [ -d "$1" ] && [ "$(ls -A "$1")" ]
}

# Update package list
print_status "Updating package list"
apt-get update

# Install git and lua5.3 if not already installed (needed for cloning dependencies and running genie)
if ! command -v git &> /dev/null || ! command -v lua5.3 &> /dev/null; then
    print_status "Installing git and lua5.3"
    apt-get install -y git lua5.3
fi

# Check if bx directory exists, if not clone it
if ! dir_exists_and_not_empty "bx"; then
    print_status "Cloning bx dependency"
    git clone https://github.com/bkaradzic/bx.git
else
    print_status "bx directory already exists"
fi

# Check if bimg directory exists, if not clone it
if ! dir_exists_and_not_empty "bimg"; then
    print_status "Cloning bimg dependency"
    git clone https://github.com/bkaradzic/bimg.git
else
    print_status "bimg directory already exists"
fi

# Build tools needed for bgfx
print_status "Building genie tool"
cd bx
# Check if we're in the right directory
if [ ! -d ".git" ] || [ ! -d "src" ]; then
    print_status "Not in the correct bx directory"
    exit 1
fi

# Try to build using make first, which should handle building genie
print_status "Attempting to build using make"
if ! make; then
    print_status "Make failed, trying alternative build method"
    # If make fails, try to build the tools directly
    cd tools/bin/linux
    # Check if genie executable already exists
    if [ ! -f "genie" ]; then
        print_status "Genie executable not found, attempting to build"
        # Try to build genie directly
        g++ -o genie ../../src/genie/bin/*.cpp -I../../src/genie/3rdparty -I../../src/genie/include -I../../src/genie/tools -lpthread
    else
        print_status "Genie executable already exists"
    fi
    cd ../../../..
fi

cd ..

# Build bgfx for Linux GCC x64 Release
print_status "Building bgfx for Linux GCC x64 Release"
# First generate the project files using genie
./bx/tools/bin/linux/genie --with-tools --with-combined-examples --with-shared-lib --gcc=linux-gcc gmake
# Then build using make
make -C .build/projects/gmake-linux-gcc config=release64

print_status "Build completed successfully!"