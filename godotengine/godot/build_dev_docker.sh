#!/bin/bash

# 构建Godot开发环境Docker镜像
echo "Building Godot development Docker image..."
docker build -t godot-dev-env -f Dockerfile.dev .

if [ $? -eq 0 ]; then
    echo "Docker image built successfully!"
    echo ""
    echo "To run the container and build Godot:"
    echo "  docker run --rm -v \$(pwd):/godot godot-dev-env"
    echo ""
    echo "To run unit tests after building:"
    echo "  docker run --rm -v \$(pwd):/godot godot-dev-env ./bin/godot.linuxbsd.editor.* --test"
    echo ""
    echo "To get a shell in the development environment:"
    echo "  docker run --rm -it -v \$(pwd):/godot godot-dev-env bash"
else
    echo "Docker image build failed!"
    exit 1
fi