#!/bin/bash
# Test script for the development environment

echo "Testing development environment..."

# Check if required tools are available
echo "Checking for required tools:"
which g++
which make
which git
which vim

# Check if the project was copied correctly
echo -e "\nChecking project files:"
ls -la

# Check if the library was built
echo -e "\nChecking built library:"
ls -la build/

echo "Development environment test completed."