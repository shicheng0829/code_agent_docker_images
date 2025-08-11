# Use Ubuntu 25.04 as the base image, matching the CI environment
FROM ubuntu:25.04

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install dependencies as per the CI configuration
RUN apt-get update && \
    apt-get -y install software-properties-common && \
    add-apt-repository --yes ppa:texus/raylib && \
    apt-get update && \
    apt-get -y install \
    g++ \
    clang \
    clang-tidy \
    ninja-build \
    cppcheck \
    cmake \
    libsfml-dev \
    libsdl2-dev \
    libsdl2-ttf-dev \
    libglfw3-dev \
    libraylib5-dev \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the project with tests enabled
RUN cmake -B build -GNinja \
    -DCMAKE_CXX_CPPCHECK="cppcheck;--enable=all;--inline-suppr;--quiet;--suppress=*:*/extlibs/*;--suppress=preprocessorErrorDirective;--suppress=noExplicitConstructor;--suppress=unmatchedSuppression;--suppress=missingIncludeSystem;--suppress=useStlAlgorithm;--suppress=passedByValue;--suppress=unusedFunction;--suppress=virtualCallInConstructor" \
    -DCMAKE_INSTALL_PREFIX=build/install \
    -DCMAKE_BUILD_TYPE=Debug \
    -DBUILD_SHARED_LIBS=ON \
    -DTGUI_CXX_STANDARD=17 \
    -DTGUI_WARNINGS_AS_ERRORS=ON \
    -DTGUI_BUILD_EXAMPLES=ON \
    -DTGUI_BUILD_GUI_BUILDER=ON \
    -DTGUI_BUILD_TESTS=ON \
    -DCMAKE_UNITY_BUILD=OFF \
    -DTGUI_BACKEND=Custom \
    -DTGUI_HAS_BACKEND_SFML_GRAPHICS=ON \
    -DTGUI_HAS_BACKEND_SFML_OPENGL3=ON \
    -DTGUI_HAS_BACKEND_SDL_OPENGL3=ON \
    -DTGUI_HAS_BACKEND_SDL_GLES2=ON \
    -DTGUI_HAS_BACKEND_SDL_TTF_OPENGL3=ON \
    -DTGUI_HAS_BACKEND_SDL_TTF_GLES2=ON \
    -DTGUI_HAS_BACKEND_GLFW_OPENGL3=ON \
    -DTGUI_HAS_BACKEND_GLFW_GLES2=ON \
    -DTGUI_HAS_BACKEND_RAYLIB=ON \
    -Draylib_USE_STATIC_LIBS=OFF && \
    cmake --build build --config Debug --target install

# Default command to run tests with xvfb
CMD ["xvfb-run", "--auto-servernum", "/app/build/tests/tests"]