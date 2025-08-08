# Copyright (c) Facebook, Inc. and its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:22.04

# Set non-interactive mode for apt
ARG DEBIAN_FRONTEND="noninteractive"
ARG tz="Etc/UTC"
ENV TZ=${tz}

# Install prerequisites
RUN apt update && \
    apt install -y sudo lsb-release pip python3 && \
    rm -rf /var/lib/apt/lists/*

# Copy necessary files
COPY scripts /velox/scripts/
COPY CMake/resolve_dependency_modules/arrow/cmake-compatibility.patch /
COPY . /velox/

# Set environment variables
ENV VELOX_ARROW_CMAKE_PATCH=/cmake-compatibility.patch \
    UV_TOOL_BIN_DIR=/usr/local/bin \
    UV_INSTALL_DIR=/usr/local/bin \
    INSTALL_PREFIX=/usr/local

# Setup Velox dependencies
WORKDIR /velox
RUN /bin/bash -o pipefail /velox/scripts/setup-ubuntu.sh

# Build Velox with tests
RUN mkdir -p _build && \
    cd _build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DVELOX_BUILD_TESTING=ON -DVELOX_ENABLE_DUCKDB=ON && \
    make -j$(nproc)

# Default command to run tests
CMD ["bash", "-c", "cd /velox/_build && make test"]