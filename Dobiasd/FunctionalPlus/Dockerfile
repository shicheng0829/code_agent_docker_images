# Use the latest Ubuntu LTS as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        git && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project into the container
COPY . .

# Install doctest and build the project
RUN ./script/ci.sh run_build

# Define the command to run tests
CMD ["./script/ci.sh", "run_tests"]