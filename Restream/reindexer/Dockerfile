FROM golang:1.22-bookworm

# Install dependencies required for building reindexer
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    libunwind-dev \
    libgoogle-perftools-dev \
    libsnappy-dev \
    libleveldb-dev \
    make \
    curl \
    unzip \
    git \
    libopenblas-pthread-dev \
    libssl-dev \
    cmake \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies
RUN go mod download

# Copy the source code
COPY . .

# Build reindexer
RUN mkdir build && cd build && cmake .. && make -j4

# Set environment variables for tests
ENV CGO_ENABLED=1

# Run tests
CMD ["go", "test", "-v", "./test/..."]