# Copyright © SixtyFPS GmbH <info@slint.dev>
# SPDX-License-Identifier: GPL-3.0-only OR LicenseRef-Slint-Royalty-free-2.0 OR LicenseRef-Slint-Software-3.0

# Use Ubuntu 24.04 as the base image to get Python 3.12+
FROM ubuntu:24.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies needed for building and testing
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        # Basic build tools
        build-essential \
        curl \
        wget \
        git \
        ca-certificates \
        # Rust build dependencies
        pkg-config \
        # Qt dependencies (for Qt backend)
        qtbase5-dev \
        # X11 dependencies (for running tests with headless display)
        libxcb-shape0-dev \
        libxcb-xfixes0-dev \
        libxkbcommon-dev \
        libxkbcommon-x11-dev \
        libxcb-icccm4-dev \
        libxcb-image0-dev \
        libxcb-keysyms1-dev \
        libxcb-randr0-dev \
        libxcb-render-util0-dev \
        libxcb-xinerama0-dev \
        libxcb-xinput-dev \
        libxcb-xfixes0-dev \
        libgl1-mesa-dev \
        libglx-dev \
        libegl1-mesa-dev \
        libgles2-mesa-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        # Multimedia dependencies
        libavcodec-dev \
        libavformat-dev \
        libavutil-dev \
        libavfilter-dev \
        libavdevice-dev \
        libasound2-dev \
        # GStreamer dependencies
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        # Python dependencies
        python3 \
        python3-pip \
        python3-venv \
        # Node.js dependencies
        nodejs \
        npm \
        # Package managers
        cmake \
        ninja-build \
        # Additional tools
        clang \
        libunwind-dev \
        && \
    rm -rf /var/lib/apt/lists/*

# Install pnpm globally
RUN npm install -g pnpm@10.11.0

# Install Rust using rustup
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path \
    && chmod -R a+w $RUSTUP_HOME $CARGO_HOME

# Install additional Rust targets and components
RUN rustup component add clippy rustfmt

# Install wasm-pack for WebAssembly builds
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

# Set up environment variables for headless testing
ENV QT_QPA_PLATFORM=offscreen \
    DISPLAY=:99

# Create a non-root user
RUN useradd -m -u 1000 user
USER user

# Set working directory
WORKDIR /home/user/slint

# Copy the project files
COPY --chown=user . .

# Install Python dependencies with pip
RUN pip3 install nox
RUN pip3 install maturin
ENV PATH="/home/user/.local/bin:${PATH}"
RUN cd api/python/slint && pip3 install -e .
RUN cd api/python/compiler && pip3 install -e .
RUN cd api/python/briefcase && pip3 install -e .

# Install Node.js dependencies
RUN cd api/node && pnpm install --frozen-lockfile

# Document the default command
CMD ["cargo", "test", "--verbose", "--workspace", "--exclude", "ffmpeg", "--exclude", "gstreamer-player", "--exclude", "bevy-example", "--exclude", "slint-node", "--exclude", "pyslint", "--exclude", "test-driver-node", "--exclude", "test-driver-nodejs", "--exclude", "test-driver-cpp", "--exclude", "mcu-board-support", "--exclude", "mcu-embassy", "--exclude", "printerdemo_mcu", "--exclude", "uefi-demo", "--exclude", "slint-cpp", "--exclude", "slint-python", "--", "--skip=_qt::t"]