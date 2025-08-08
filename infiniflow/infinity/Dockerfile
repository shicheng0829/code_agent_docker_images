# Dockerfile for Infinity development environment
# This Dockerfile creates an environment for building and running unit tests

FROM infiniflow/infinity_builder:ubuntu20_clang20

# Set working directory
WORKDIR /infinity

# Copy the project files
COPY . .

# Create necessary directories
RUN sudo mkdir -p /var/infinity && sudo chown -R $(id -u):$(id -g) /var/infinity

# Build only the unit tests in debug mode
# Add BMI2 support for SIMD instructions
RUN cd /infinity && rm -fr cmake-build-debug && mkdir -p cmake-build-debug && \
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_JOB_POOLS:STRING=link=8 -DCI=ON -DSIMD_OPTION="-mbmi2" -S /infinity -B /infinity/cmake-build-debug && \
    cmake --build /infinity/cmake-build-debug --target test_main

# Install Python dependencies
RUN pip3 install -r python/requirements.txt

# Default command - run unit tests
CMD ["cmake-build-debug/src/test_main"]