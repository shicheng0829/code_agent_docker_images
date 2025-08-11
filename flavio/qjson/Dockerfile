FROM ubuntu:18.04

# Install dependencies including development tools
RUN apt-get update && apt-get install -y \
    cmake \
    make \
    g++ \
    qt5-default \
    libqt5test5 \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Create build directory and build the project with tests enabled
RUN mkdir build && cd build && \
    cmake -DQJSON_BUILD_TESTS=yes -DQT4_BUILD=OFF -DQT_QMAKE_EXECUTABLE=/usr/bin/qmake .. && \
    make

# Default command runs tests
CMD ["sh", "-c", "cd build && make test"]

# Development script to rebuild and test
RUN echo '#!/bin/bash\ncd build\ncmake -DQJSON_BUILD_TESTS=yes -DQT4_BUILD=OFF -DQT_QMAKE_EXECUTABLE=/usr/bin/qmake .. && \
make && \
make test\n' > /usr/local/bin/dev-run && \
chmod +x /usr/local/bin/dev-run