# Use Ubuntu 22.04 as the base image for newer CMake version
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ruby \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Generate fff.h if needed (using ruby script)
RUN ruby fakegen.rb > fff.h

# Build and test the project
CMD ["./buildandtest"]