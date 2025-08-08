#!/bin/bash

if [ "$1" = "unit" ]; then
    echo "Running unit tests..."
    ./vcpkg install unit-test-cmake --overlay-ports=scripts/test_ports
elif [ "$1" = "features" ]; then
    echo "Running feature tests..."
    ./vcpkg x-test-features --for-merge-with=HEAD --triplet=x64-linux --ci-feature-baseline=scripts/ci.feature.baseline.txt --failing-abi-log=/tmp/failing-abi-log.txt --overlay-ports=scripts/test_ports
elif [ "$1" = "ci" ]; then
    echo "Running CI tests (dry-run)..."
    ./vcpkg ci --dry-run --triplet=x64-linux --overlay-ports=scripts/test_ports
else
    echo "Usage: $0 [unit|features|ci]"
    echo "  unit     - Run unit tests"
    echo "  features - Run feature tests"
    echo "  ci       - Run CI tests (dry-run)"
    exit 1
fi