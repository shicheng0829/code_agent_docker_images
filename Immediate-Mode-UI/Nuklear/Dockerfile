# Use Ubuntu as the base image
FROM ubuntu:latest

# Set non-interactive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for building and running tests
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    glslc \
    liballegro5-dev \
    liballegro-image5-dev \
    liballegro-ttf5-dev \
    libcairo2-dev \
    libglfw3 \
    libglfw3-dev \
    libglew-dev \
    libsdl2-dev \
    libvulkan-dev \
    libwayland-dev \
    libx11-dev \
    libxcb1-dev \
    libxcb-util0-dev \
    libxcb-keysyms1-dev \
    libxft-dev \
    libxkbcommon-x11-dev \
    wayland-protocols \
    make \
    gcc \
    g++ \
    python3 \
    xxd \
    libsfml-dev \
    libsdl2-ttf-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/nuklear

# Copy the current directory contents into the container at /usr/src/nuklear
COPY . .

# Build all demos except sfml_opengl3
RUN make -C demo/allegro5 && \
    make -C demo/glfw_opengl2 && \
    make -C demo/glfw_opengl3 && \
    make -C demo/glfw_opengl4 && \
    make -C demo/glfw_vulkan && \
    make -C demo/glfw_vulkan/src && \
    make -C demo/rawfb/sdl && \
    make -C demo/rawfb/wayland && \
    make -C demo/rawfb/x11 && \
    make -C demo/sdl_opengl2 && \
    make -C demo/sdl_opengl3 && \
    make -C demo/sdl_opengles2 && \
    make -C demo/sdl_renderer && \
    make -C demo/sdl_vulkan && \
    make -C demo/sdl_vulkan/src && \
    make -C demo/sfml_opengl2

# Build examples
RUN make -C example

# Default command (can be overridden)
CMD ["bash"]