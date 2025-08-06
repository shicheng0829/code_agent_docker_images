FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash xmakeuser

# Switch to the non-root user
USER xmakeuser

# Set home environment variable
ENV HOME=/home/xmakeuser

# Install xmake
RUN curl -fsSL https://xmake.io/shget.text | bash

# Set environment variable for PATH
ENV PATH="${HOME}/.local/bin:${PATH}"

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Run tests
CMD ["bash", "-c", "xmake && xmake run demo && xmake f -m debug && xmake -r && xmake run demo && xmake f --micro=y && xmake -r && xmake run demo && xmake f --small=y -m debug && xmake -r && xmake run demo"]