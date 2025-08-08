# Use a base image that matches the CI environment
FROM gcr.io/google.com/absl-177019/linux_hybrid-latest:20250430

# Set the working directory
WORKDIR /src

# Copy the source code into the container
COPY . .

# Build and run tests using CMake
RUN mkdir build && \
    cd build && \
    cmake .. \
        -DCMAKE_CXX_STANDARD=17 \
        -Dgtest_build_samples=ON \
        -Dgtest_build_tests=ON \
        -Dgmock_build_tests=ON && \
    make -j$(nproc) && \
    ctest -j$(nproc) --output-on-failure