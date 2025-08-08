FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    libclang-dev \
    clang \
    clang-format \
    clang-tidy \
    emacs \
    cmake \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/irony-mode

# Copy the source code
COPY . .

# Build the project
RUN mkdir build && cd build && \
    cmake -DCMAKE_CXX_FLAGS="-Wall -Wextra -Werror" \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
          ../server && \
    make -k

# Run tests
CMD ["make", "check"]