# Use Ubuntu 24.04 as the base image, matching the CI environment
FROM ubuntu:24.04

# Set environment variables to non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install dependencies required for building bgfx
# This includes build tools, libraries for graphics development, and utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libgl-dev \
    ca-certificates \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the entire project directory into the container
# This assumes the Dockerfile is in the root of the bgfx repository
COPY . .

# Copy and make the build script executable
COPY build.sh /usr/local/bin/build.sh
RUN chmod +x /usr/local/bin/build.sh

# The bgfx project requires its dependencies (bx and bimg) to be checked out
# These are typically expected to be sibling directories.
# We'll handle this during the build process in the container.

# Define the default command to run when the container starts
# This will be overridden by docker run commands
CMD ["/bin/bash"]