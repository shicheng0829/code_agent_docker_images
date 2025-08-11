# Use the same base image as the CI scripts
FROM gcr.io/google.com/absl-177019/linux_hybrid-latest:20240523

# Install necessary packages
RUN apt-get update && apt-get install -y \
    g++ \
    clang \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /tcmalloc

# Copy the source code into the container
COPY . .

# Set environment variables for Bazel
ENV CC=/usr/local/bin/gcc
ENV BAZEL_CXXOPTS=-std=c++17

# Command to run tests
CMD ["bazel", "test", "--test_output=errors", "//..."]