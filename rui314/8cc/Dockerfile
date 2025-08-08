FROM ubuntu:14.04

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python2.7 \
    && rm -rf /var/lib/apt/lists/*

# Create symbolic links for python
RUN ln -s /usr/bin/python2.7 /usr/bin/python && \
    ln -s /usr/bin/python2.7 /usr/bin/python2

# Set working directory
WORKDIR /app

# Copy all source files
COPY . .

# Build the project
RUN make

# Run tests
CMD ["make", "test"]