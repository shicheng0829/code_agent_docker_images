# Dockerfile for Universal project development
# This Dockerfile sets up an environment for building and testing the Universal library

FROM gcc:10.4

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    curl \
    vim \
    gdb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install a specific cmake version (as required by the project)
RUN set -ex \
  && for key in C6C265324BBEBDC350B513D02D2CEF1034921684; do \
    gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys "$key" ; \
  done

ENV CMAKE_DIR="v3.23"
ENV CMAKE_VERSION="3.23.1"

RUN set -ex \
  && curl -fsSLO --compressed https://cmake.org/files/${CMAKE_DIR}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz \
  && curl -fsSLO https://cmake.org/files/${CMAKE_DIR}/cmake-${CMAKE_VERSION}-SHA-256.txt.asc \
  && curl -fsSLO https://cmake.org/files/${CMAKE_DIR}/cmake-${CMAKE_VERSION}-SHA-256.txt \
  && gpg --verify cmake-${CMAKE_VERSION}-SHA-256.txt.asc cmake-${CMAKE_VERSION}-SHA-256.txt \
  && grep "cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz$" cmake-${CMAKE_VERSION}-SHA-256.txt | sha256sum -c - \
  && tar xzf cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz -C /usr/local --strip-components=1 --no-same-owner \
  && rm -rf cmake-${CMAKE_VERSION}*

# Create and use user stillwater
RUN useradd -ms /bin/bash stillwater
USER stillwater

# Set working directory
WORKDIR /home/stillwater/universal

# Copy project files
COPY --chown=stillwater:stillwater . .

# Create build directory
RUN mkdir -p build

# Provide a script to run tests selectively
RUN echo '#!/bin/bash\necho "Available test commands:"\necho "  cmake -DCMAKE_BUILD_TYPE=Release -DUNIVRSL_BUILD_CI=ON .. && cmake --build . --config Release"\necho "  ctest -C Release"\necho ""\necho "Note: Some components may not build on ARM64 due to long double compatibility issues."\necho "To skip problematic components, you can use:"\necho "  cmake -DCMAKE_BUILD_TYPE=Release -DUNIVRSL_BUILD_CI=ON -DUNIVRSL_BUILD_APP_ENVIRONMENT=OFF -DUNIVRSL_BUILD_NUMBER_AREALS=OFF .."' > README.docker && chmod +x README.docker

# Default command - run bash for development
CMD ["/usr/bin/env", "bash"]