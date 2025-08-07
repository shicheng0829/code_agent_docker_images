# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install build essentials and other necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/libutp

# Copy the current directory contents into the container at /usr/src/libutp
COPY . .

# Build the project
RUN make

# Run tests (assuming 'make test' or similar would be the command)
# Since there's no explicit test target, we'll just verify the build by running make
CMD ["make"]