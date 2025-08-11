FROM ubuntu:18.04

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    clang-6.0 \
    libstdc++6 \
    libstdc++-5-dev \
    && rm -rf /var/lib/apt/lists/*

# Create symlink for clang++
RUN ln -s /usr/bin/clang-6.0 /usr/bin/clang++

# Set working directory
WORKDIR /app

# Copy the project files
COPY . .

# Initialize submodules to get geometry dependency
RUN git submodule update --init

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libboost-all-dev \
    rapidjson-dev \
    catch \
    libbenchmark-dev \
    && rm -rf /var/lib/apt/lists/*

# Modify CMakeLists.txt to use system packages instead of mason
RUN sed -i 's/mason_use/#mason_use/g' CMakeLists.txt && \
    sed -i 's/include(\${CMAKE_CURRENT_SOURCE_DIR}/cmake/mason.cmake)/#include(\${CMAKE_CURRENT_SOURCE_DIR}/cmake/mason.cmake)/g' CMakeLists.txt && \
    sed -i 's/target_link_libraries(bench-tests \${MASON_PACKAGE_benchmark_STATIC_LIBS} \${MASON_PACKAGE_boost_libfilesystem_STATIC_LIBS} \${MASON_PACKAGE_boost_libsystem_STATIC_LIBS} \${CMAKE_THREAD_LIBS_INIT})/target_link_libraries(bench-tests benchmark \${CMAKE_THREAD_LIBS_INIT})/g' CMakeLists.txt

# Add system package includes to CMakeLists.txt
RUN echo "" >> CMakeLists.txt && \
    echo "# System package includes" >> CMakeLists.txt && \
    echo "find_package(Boost REQUIRED COMPONENTS system filesystem)" >> CMakeLists.txt && \
    echo "include_directories(SYSTEM \${Boost_INCLUDE_DIRS})" >> CMakeLists.txt && \
    echo "link_directories(\${Boost_LIBRARY_DIRS})" >> CMakeLists.txt && \
    echo "" >> CMakeLists.txt && \
    echo "# Add definitions for Boost" >> CMakeLists.txt && \
    echo "add_definitions(-DBOOST_ALL_NO_LIB)" >> CMakeLists.txt && \
    echo "" >> CMakeLists.txt && \
    echo "# Include directories for other dependencies" >> CMakeLists.txt && \
    echo "include_directories(SYSTEM /usr/include/rapidjson)" >> CMakeLists.txt && \
    echo "include_directories(SYSTEM /usr/include/catch)" >> CMakeLists.txt

# Create a simple build script
RUN echo '#!/bin/bash' > build.sh && \
    echo 'export CXX=/usr/bin/clang++' >> build.sh && \
    echo 'mkdir -p ./cmake-build && cd ./cmake-build && cmake ../ -DCMAKE_BUILD_TYPE=Debug -DWERROR=false && VERBOSE=1 cmake --build .' >> build.sh && \
    chmod +x build.sh

# Build the project
RUN ./build.sh

# Default command to run tests
CMD ["bash", "-c", "cd cmake-build && ./unit-tests"]