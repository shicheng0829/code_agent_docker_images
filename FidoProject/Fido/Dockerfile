FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    make \
    libsfml-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the project
RUN make && make lib

# Make test script executable
RUN chmod +x ./runtests_docker.sh

# Default command to run tests
CMD ["./runtests_docker.sh"]